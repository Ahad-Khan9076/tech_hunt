import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/phone_controllers.dart';

class PhoneInputScreen extends StatelessWidget {
  final PhoneController _phoneController = Get.put(PhoneController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Verification"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              // Icon instead of Image
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.phone_android, // Use a phone icon
                    size: 60,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Title Text
              Text(
                "Enter Your Phone Number",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              // Subtitle
              Text(
                "We will send you a verification code.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              // Phone Number Input Field
              TextField(
                onChanged: (value) {
                  _phoneController.phoneNumber.value = "+92" + value.trim(); // Example: "+923001234567"
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "e.g. 3001234567",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blueAccent),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: Icon(Icons.phone, color: Colors.blueAccent),
                ),
              ),
              SizedBox(height: 20),
              // Send Code Button
              Obx(() {
                return Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent, // Button color
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: _phoneController.isLoading.value ? null : _phoneController.sendOtp,
                    child: _phoneController.isLoading.value
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                        SizedBox(width: 10),
                        Text("Sending...", style: TextStyle(color: Colors.white)),
                      ],
                    )
                        : Text("Send Code", style: TextStyle(fontSize: 18)),
                  ),
                );
              }),
              SizedBox(height: 30),
              // Additional Text
              Text(
                "By clicking Send Code, you agree to our Terms & Conditions",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[500], fontSize: 14),
              ),
              SizedBox(height: 10),
              // Have an account? Login
              GestureDetector(
                onTap: () {
                  // Navigate to Login Screen
                  Get.toNamed('/login'); // Update with your login route
                },
                child: Text(
                  "Already have an account? Login",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
