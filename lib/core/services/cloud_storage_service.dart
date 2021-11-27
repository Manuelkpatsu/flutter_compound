import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class CloudStorageService {
  Future<CloudStorageResult?> uploadImage({
    required File imageToUpload,
    required String title,
  }) async {
    var imageFileName = title + DateTime.now().millisecondsSinceEpoch.toString();

    final firebase_storage.Reference firebaseStorageRef =
        firebase_storage.FirebaseStorage.instance.ref().child(imageFileName);

    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);

    firebase_storage.TaskSnapshot storageSnapshot = uploadTask.snapshot;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (storageSnapshot.state == firebase_storage.TaskState.success) {
      var url = downloadUrl.toString();

      return CloudStorageResult(imageUrl: url, imageFileName: imageFileName);
    }

    return null;
  }

  Future deleteImage(String imageFileName) async {
    final firebase_storage.Reference firebaseStorageRef =
        firebase_storage.FirebaseStorage.instance.ref().child(imageFileName);

    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }
}

class CloudStorageResult {
  final String? imageUrl;
  final String? imageFileName;

  CloudStorageResult({this.imageUrl, this.imageFileName});
}
