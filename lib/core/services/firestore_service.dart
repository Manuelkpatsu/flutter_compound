import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttercompoundapp/core/models/post.dart';
import 'package:fluttercompoundapp/core/models/user.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference _postsCollectionReference =
      FirebaseFirestore.instance.collection('posts');

  // Create the controller that will broadcast the posts
  final StreamController<List<Post>> _postsController =
      StreamController<List<Post>>.broadcast();

  Future createUser(AuthUser user) async {
    try {
      await _usersCollectionReference.doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      DocumentSnapshot userData = await _usersCollectionReference.doc(uid).get();
      return AuthUser.fromData(userData.data() as Map<String, dynamic>);
    } on FirebaseException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future addPost(Post post) async {
    try {
      await _postsCollectionReference.add(post.toJson());
      return true;
    } on FirebaseException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future getPostsOnceOff() async {
    try {
      QuerySnapshot postDocuments = await _postsCollectionReference.get();

      if (postDocuments.docs.isNotEmpty) {
        return postDocuments.docs
            .map((snapshot) => Post.fromData(snapshot.data() as Map<String, dynamic>))
            .where((post) => post.title.isNotEmpty)
            .toList();
      }
    } on FirebaseException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Stream listenToPostsRealTime() {
    // Register the handler for when the posts data changes
    _postsCollectionReference.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.docs.isNotEmpty) {
        var posts = postsSnapshot.docs
            .map((snapshot) => Post.fromData(snapshot.data() as Map<String, dynamic>))
            .where((mappedItem) => mappedItem.title.isNotEmpty)
            .toList();

        // Add the posts onto the controller
        _postsController.add(posts);
      }
    }).onError((e) {
      throw e.toString();
    });

    // Return the stream underlying our _postsController.
    return _postsController.stream;
  }
}
