import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize Firebase Auth

  // Constructor to accept the email parameter
  ForgotPasswordScreen({Key? key, String? email}) : super(key: key) {
    if (email != null) {
      emailController.text = email; // Pre-fill the email field if provided
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text("Forgot Password", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade600, Colors.blue.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Forgot Password?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Enter your email address below to receive instructions for resetting your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 30),
                _buildEmailTextField(),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text.trim();
                    if (email.isNotEmpty) {
                      try {
                        await _auth.sendPasswordResetEmail(email: email);
                        Get.snackbar(
                          'Success',
                          'Password reset link sent!',
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.white,
                          backgroundColor: Colors.green,
                        );
                      } on FirebaseAuthException catch (e) {
                        Get.snackbar(
                          'Error',
                          e.message ?? 'An error occurred.',
                          snackPosition: SnackPosition.BOTTOM,
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                        );
                      }
                    } else {
                      Get.snackbar(
                        'Error',
                        'Please enter an email address.',
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.white,
                        backgroundColor: Colors.red,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Send Reset Link',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white10,
        prefixIcon: Icon(Icons.email, color: Colors.white),
      ),
      style: TextStyle(color: Colors.white),
    );
  }
}
