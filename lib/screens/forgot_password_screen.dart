import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove background color from the scaffold
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Get.back(); // Use GetX to navigate back
          },
        ),
        title: Text("Forgot Password", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue.shade600,
      ),
      body: Container(
        // Ensure this container expands to fill the screen
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
                // Title
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

                // Description
                Text(
                  'Enter your email address below to receive instructions for resetting your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 30),

                // Email Input Field
                _buildEmailTextField(),

                SizedBox(height: 30),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    // Handle password reset logic here
                    print('Reset password for: ${emailController.text}');
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

                // Back to Login
              
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build the email input field
  Widget _buildEmailTextField() {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.blue.shade200.withOpacity(0.2),
        prefixIcon: Icon(Icons.email, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white54),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.emailAddress,
    );
  }
}
