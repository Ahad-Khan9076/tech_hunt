import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../routes/app_route.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  Future<void> loginUser() async {
    setState(() {
      isLoading = true;
    });
    try {
      // Authenticate the user
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;

      if (user != null) {
        // Fetch the user role from Firestore
        DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          String role = userDoc['role']; // Assuming role is stored as 'role'
          navigateBasedOnRole(role);
        } else {
          Get.snackbar('Error', 'User data not found!');
        }
      }
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigateBasedOnRole(String role) {
    if (role == 'Buyer') {
      Get.offNamed(AppRoutes.buyerScreen);
    } else if (role == 'Seller') {
      Get.offNamed(AppRoutes.sellerScreen);
    } else if (role == 'Admin') {
      Get.offNamed(AppRoutes.adminScreen);
    } else {
      Get.snackbar('Error', 'Invalid user role!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade500, Colors.blue.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_pin, size: 100, color: Colors.white),
                SizedBox(height: 30),
                Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: loginUser,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    backgroundColor: Colors.blue.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Login',
                      style: TextStyle(
                          fontSize: 18, color: Colors.white)),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.signupScreen);
                      },
                      child: Text(
                        "Signup",
                        style: TextStyle(
                            color: Colors.blue.shade200,
                            fontSize: 16,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.forgotPasswordScreen);
                  },
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        color: Colors.blue.shade200,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
