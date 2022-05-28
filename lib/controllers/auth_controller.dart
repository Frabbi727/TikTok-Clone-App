import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktoc_clone_app/constants.dart';

import '../models/user.dart' as model;

// class AuthController extends GetxController {
//   static AuthController instance = Get.find();
// // Image Picker
//   late Rx<File?> _pickedImage;
//   File? get profilePhoto => _pickedImage.value;
//   Future<void> pickImage() async {
//     final pickedImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       Get.snackbar('Profile Picture',
//           'You have successfully picked your profile picture');
//     }
//     _pickedImage = Rx<File?>(File(pickedImage!.path));
//   }

//   // Upload Image to storage
//   Future<String> _uploadToStorage(File image) async {
//     Reference ref = firebaseStorage
//         .ref()
//         .child('profilePics')
//         .child(firebaseAuth.currentUser!.uid);
//     UploadTask uploadTask = ref.putFile(image);
//     TaskSnapshot snap = await uploadTask;
//     String dowanloadUrl = await snap.ref.getDownloadURL();
//     return dowanloadUrl;
//   }

//   // Register the user here
//   void registerUser(
//       String userName, String email, String password, File? image) async {
//     try {
//       if (userName.isNotEmpty && email.isNotEmpty && image != null) {
//         // save data in firebase

//         UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
//             email: email, password: password);

//         String dowanloadUrl = await _uploadToStorage(image);

//         model.User user = model.User(
//           name: userName,
//           email: email,
//           profilePhoto: dowanloadUrl,
//           uid: cred.user!.uid,
//         );
//         await firestore
//             .collection('users')
//             .doc(cred.user!.uid)
//             .set(user.toJson());
//         print('firestore ok');

// // Printg user information in terminal
//         print(userName);
//         print(email);
//         print(cred.user!.uid);
//         print(password);
//       } else {
//         Get.snackbar('User Not created', 'Please enter all fields');
//       }
//     } catch (e) {
//       Get.snackbar('Error Creating App', e.toString());
//     }
//   }
// }

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  // PickImage from gallery
  late Rx<File?> _pickedImage;
  File? get profilePhoto => _pickedImage.value;

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickImage != null) {
      Get.snackbar('Upload Image', 'You Successfully picke an image');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

// Creating a function to upload image to firebase storeage
  Future<String> _uploadToStorage(File image) async {
    print('enter into the image url dowanload block // AuthController file');
    Reference ref = firebaseStorage
        .ref()
        .child('profilepics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    print(downloadUrl);
    return downloadUrl;
  }

// Register The user
  void registerUser(
      String userName, String email, String password, File? image) async {
    try {
      print(' Enter Into the try block // AuthController file');
      if (userName.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        print('Enter into the if statemnt // AuthController file');
// if all are ok then save email and password save for authentication and save other data to firebase database
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
            print('Upload image');
// image Uplodad
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: userName,
          email: email,
          uid: cred.user!.uid,
          profilePhoto: downloadUrl,
        );
        print('enter 001****');
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(
              user.toJson(),
            );

// print data on console
        print(
            ' information from the text field for registerUser function // AuthController file');
        print(userName);
        print(email);
        print(password);
        print(firebaseAuth.currentUser!.uid);
        print(downloadUrl);
        print('Out from the if statement//');
      } else {
        print('enter into the else statemnt error 1// AuthController file');
        Get.snackbar('Error (1) from else condition', 'Fill all data fields');
      }
    } catch (e) {
      print('enter into the catch block // AuthController file');
      Get.snackbar('Error (2) for creating account', e.toString());
      print(e.toString());
    }
  }
}
