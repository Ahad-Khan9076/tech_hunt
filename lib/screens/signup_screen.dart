import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../routes/app_route.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final List<String> roles = ['Admin', 'Seller', 'Buyer'];
  String? selectedRole;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  Future<void> registerUser() async {
    if (selectedRole == null) {
      Get.snackbar('Error', 'Please select a role');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Register user in Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      User? user = userCredential.user;

      if (user != null) {
        // Store user data in Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'email': emailController.text.trim(),
          'name': nameController.text.trim(),
          'phone': phoneController.text.trim(),
          'age': ageController.text.trim(),
          'city': cityController.text.trim(),
          'postalCode': postalCodeController.text.trim(),
          'role': selectedRole,
        });

        // Update the state to stop loading indicator
        setState(() {
          isLoading = false;
        });

        // Show success message
        Get.snackbar('Success', 'User created successfully!');

        // Navigate to login screen after a short delay to show the snackbar
        Future.delayed(Duration(seconds: 1), () {
          Get.toNamed(AppRoutes.loginScreen);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      Get.snackbar('Registration Failed', e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                  'Create Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 30),
                _buildTextField('Email', Icons.email, emailController),
                SizedBox(height: 15),
                _buildTextField('Name', Icons.person, nameController),
                SizedBox(height: 15),
                _buildTextField('Phone Number', Icons.phone, phoneController),
                SizedBox(height: 15),
                _buildTextField('Age', Icons.cake, ageController),
                SizedBox(height: 15),
                _buildTextField('City', Icons.location_city, cityController),
                SizedBox(height: 15),
                _buildTextField('Postal Code', Icons.local_post_office, postalCodeController),
                SizedBox(height: 15),
                _buildTextField('Password', Icons.lock, passwordController, isPassword: true),
                SizedBox(height: 15),
                _buildRoleDropdown(),
                SizedBox(height: 30),
                isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: registerUser,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.loginScreen);
                    },
                    child: Text(
                      "Already have an account? Login here",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.blue.shade200.withOpacity(0.2),
        prefixIcon: Icon(icon, color: Colors.white),
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
    );
  }

  Widget _buildRoleDropdown() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade200.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Role',
          labelStyle: TextStyle(color: Colors.black),
          border: InputBorder.none,
        ),
        dropdownColor: Colors.blue.shade300,
        value: selectedRole,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            selectedRole = newValue;
          });
        },
        items: roles.map<DropdownMenuItem<String>>((String role) {
          return DropdownMenuItem<String>(
            value: role,
            child: Text(role, style: TextStyle(color: Colors.black)),
          );
        }).toList(),
      ),
    );
  }
}
