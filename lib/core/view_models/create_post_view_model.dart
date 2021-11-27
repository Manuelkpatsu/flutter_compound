// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'dart:io';

import 'package:fluttercompoundapp/core/models/post.dart';
import 'package:fluttercompoundapp/core/services/cloud_storage_service.dart';
import 'package:fluttercompoundapp/core/services/dialog_service.dart';
import 'package:fluttercompoundapp/core/services/firestore_service.dart';
import 'package:fluttercompoundapp/core/services/navigation_service.dart';
import 'package:fluttercompoundapp/utils/image_selector.dart';

import '../../locator.dart';
import 'base_model.dart';

class CreatePostViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService = locator<CloudStorageService>();

  late Post _editingPost;
  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  void setEditingPost(Post post) {
    _editingPost = post;
  }

  bool get _editing => _editingPost != null;

  Future addPost({required String title}) async {
    setBusy(true);
    CloudStorageResult? storageResult;

    if (!_editing) {
      storageResult = await _cloudStorageService.uploadImage(
          imageToUpload: _selectedImage!, title: title);
    }

    var result;

    if (!_editing) {
      result = await _firestoreService.addPost(Post(
        title: title,
        userId: currentUser.id,
        imageUrl: storageResult!.imageUrl,
        imageFileName: storageResult.imageFileName,
      ));
    } else {
      result = await _firestoreService.updatePost(Post(
        title: title,
        userId: _editingPost.userId,
        documentId: _editingPost.documentId,
        imageUrl: _editingPost.imageUrl,
        imageFileName: _editingPost.imageFileName,
      ));
    }
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not add Post',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Post successfully Added',
        description: 'Your post has been created',
      );
    }

    _navigationService.pop();
  }

  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = tempImage;
      notifyListeners();
    }
  }
}
