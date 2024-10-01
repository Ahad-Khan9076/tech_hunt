import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_route.dart';

class SignupScreen extends StatelessWidget {
  final List<String> roles = ['Admin', 'Seller', 'Buyer']; // Available roles
  String? selectedRole; // Variable to store the selected role

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
                // Title
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

                // Input Fields
                _buildTextField('Email', Icons.email),
                SizedBox(height: 15),
                _buildTextField('Name', Icons.person),
                SizedBox(height: 15),
                _buildTextField('Phone Number', Icons.phone),
                SizedBox(height: 15),
                _buildTextField('Age', Icons.cake),
                SizedBox(height: 15),
                _buildTextField('City', Icons.location_city),
                SizedBox(height: 15),
                _buildTextField('Postal Code', Icons.local_post_office),
                SizedBox(height: 15),

                // Role Dropdown
                _buildRoleDropdown(),

                SizedBox(height: 30),

                // Sign Up Button
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.loginScreen);
                  },
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

                // Already have an account?
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

  // Helper method to build a custom styled text field
  Widget _buildTextField(String label, IconData icon) {
    return TextField(
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

  // Helper method to build the role dropdown
  Widget _buildRoleDropdown() {
    return Container(
      width: 100, // Set your desired width
      height: 50, // Set your desired height
      decoration: BoxDecoration(
        color: Colors.blue.shade200.withOpacity(0.2), // Background color
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8.0,
            spreadRadius: 1.0,
            offset: Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Role',
          labelStyle: TextStyle(color: Colors.black),
          filled: true,
          border: InputBorder.none, // Remove default border
        ),
        dropdownColor: Colors.blue.shade300, // Dropdown background color
        value: selectedRole,
        isExpanded: true, // Ensures dropdown items take full width
        onChanged: (String? newValue) {
          selectedRole = newValue; // Update selected role
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
