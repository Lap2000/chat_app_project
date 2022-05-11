import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

import '../../views/widgets/snackbar.dart';
import '../models/video_model.dart';

class StorageServices {
  //Upload Image to Storage and get link
  static Future<String> uploadImage(File? imageFileX) async {
    String fileName = Uuid().v1();
    var ref =
        FirebaseStorage.instance.ref().child('images').child('$fileName.jpg');
    var uploadTask = await ref.putFile(imageFileX!);
    String ImageURL = await uploadTask.ref.getDownloadURL();
    return ImageURL;
  }

  //nén video
  static compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    return compressedVideo!.file;
  }

  //Upload Video to Storage and get link
  static Future<String> uploadVideoToStorage(
      String id, String videoPath) async {
    Reference ref = FirebaseStorage.instance.ref().child('videos').child(id);

    UploadTask uploadTask = ref.putFile(await compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // upload video to firestore cloud
  static uploadVideo(BuildContext context, String songName, String caption,
      String videoPath) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      // get id
      var allDocs = await FirebaseFirestore.instance.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await uploadVideoToStorage("Video $len", videoPath);

      Video video = Video(
        username: (userDoc.data()! as Map<String, dynamic>)['fullName'],
        uid: uid.toString(),
        id: "Video $len",
        likes: [],
        comments: [],
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        profilePhoto: (userDoc.data()! as Map<String, dynamic>)['avartaURL'],
      );

      await FirebaseFirestore.instance
          .collection('videos')
          .doc('Video $len')
          .set(
            video.toJson(),
          );
      Navigator.of(context).pop();
      getSnackBar(
        'Push Video',
        'Success.',
        Colors.green,
      ).show(context);
      //Get.back();
    } catch (e) {
      // Get.snackbar(
      //   'Error Uploading Video',
      //   e.toString(),
      // );
      print(e);
    }
  }
}
