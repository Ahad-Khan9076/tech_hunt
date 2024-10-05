import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_route.dart';

class PhoneController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var phoneNumber = ''.obs;
  var verificationId = ''.obs;
  var isLoading = false.obs;

  // Function to send OTP to the given phone number
  void sendOtp() async {
    isLoading.value = true;
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber.value,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
        isLoading.value = false;
        // Navigate to role-based screen after automatic sign-in
        await navigateToRoleBasedScreen();
      },
      verificationFailed: (FirebaseAuthException e) {
        isLoading.value = false;
        Get.snackbar(
          'Verification Failed',
          e.message ?? 'An error occurred while verifying your phone number.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
      codeSent: (String verId, int? resendToken) {
        isLoading.value = false;
        verificationId.value = verId;
        Get.snackbar(
          'Code Sent',
          'Verification code sent to your phone!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.blue,
          colorText: Colors.white,
        );
        Get.toNamed(AppRoutes.verificationScreen); // Navigate to verification screen
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId.value = verId;
      },
    );
  }

  // Function to verify the code entered by the user
  void verifyOtp(String smsCode) async {
    isLoading.value = true;
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      isLoading.value = false;
      // Navigate to role-based screen after verification
      await navigateToRoleBasedScreen();
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Verification Failed',
        "Invalid Code: ${e.toString()}",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Function to navigate based on user role
  Future<void> navigateToRoleBasedScreen() async {
    String? userId = _auth.currentUser?.uid;

    if (userId != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        String role = userDoc['role'] ?? 'unknown'; // Assuming the user's role is stored in the 'role' field

        if (role == 'buyer') {
          Get.offAllNamed(AppRoutes.buyerScreen); // Navigate to buyer screen
        } else if (role == 'admin') {
          Get.offAllNamed(AppRoutes.adminScreen); // Navigate to admin screen
        } else if (role == 'seller') {
          Get.offAllNamed(AppRoutes.sellerScreen); // Navigate to seller screen
        } else {
          Get.snackbar(
            'Error',
            'User role not found.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'User does not exist in the database.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'User not logged in.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
