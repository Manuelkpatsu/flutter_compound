import 'package:fluttercompoundapp/constants/route_names.dart';
import 'package:fluttercompoundapp/core/models/post.dart';
import 'package:fluttercompoundapp/core/services/dialog_service.dart';
import 'package:fluttercompoundapp/core/services/firestore_service.dart';
import 'package:fluttercompoundapp/core/services/navigation_service.dart';

import '../../locator.dart';
import 'base_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  List<Post> _posts = [];
  List<Post> get posts => _posts;

//  Future fetchPosts() async {
//    setBusy(true);
//    // TODO: Find or Create a TaskType that will automatically do the setBusy(true/false) when being run.
//    var postsResults = await _firestoreService.getPostsOnceOff();
//    setBusy(false);
//
//    if (postsResults is List<Post>) {
//      _posts = postsResults;
//      notifyListeners();
//    } else {
//      await _dialogService.showDialog(
//        title: 'Posts Update Failed',
//        description: postsResults,
//      );
//    }
//  }

  void listenToPosts() {
    setBusy(true);
    _firestoreService.listenToPostsRealTime().listen((postsData) {
      List<Post> updatedPosts = postsData;

      if (updatedPosts.isNotEmpty) {
        _posts = updatedPosts;
        notifyListeners();
      }
      setBusy(false);
    }).onError((e) {
      _dialogService.showDialog(
        title: 'Posts Update Failed',
        description: e,
      );
    });
  }

  void navigateToCreateView() => _navigationService.navigateTo(createPostViewRoute);
}