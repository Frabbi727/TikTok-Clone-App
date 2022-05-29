import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktoc_clone_app/constants.dart';
import 'package:tiktoc_clone_app/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
// Creating compressed video function to reduce the storage
  _compressedVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

// Upload video firestore function
  Future<String> _uoloadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    // Compressed the video for low storage
    UploadTask uploadTask = ref.putFile(await _compressedVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String dowanloadUrl = await snap.ref.getDownloadURL();
    return dowanloadUrl;
  }

  // Get thumbnail functions

  _getThumbNail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  // Uplaod video image thumbnail
  _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    // Get thumbnail from here
    UploadTask uploadTask = ref.putFile(await _getThumbNail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String dowanloadUrl = await snap.ref.getDownloadURL();
    return dowanloadUrl;
  }

  // Upload Video
  uploadVido(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();

      // get videos id
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      // function for upload video to storeage
      String videoUrl = await _uoloadVideoToStorage("Video $len", videoPath);
      // upload vido thumnai which is an image
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      Video video = Video(
        userName: (userDoc.data()! as Map<String, dynamic>)['name'],
        uid: uid,
        id: "Video $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['profilePhoto'],
      );
      await firestore.collection('videos').doc("Video $len").set(
            video.toJsorn(),
          );
          Get.back();
    } catch (e) {
      Get.snackbar('Video Upload Fieled', e.toString());
    }
  }
}
