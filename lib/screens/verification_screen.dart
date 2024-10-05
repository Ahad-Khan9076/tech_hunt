import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/phone_controllers.dart';

class VerificationScreen extends StatelessWidget {
  final PhoneController _phoneController = Get.find<PhoneController>();
  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Verification Code"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter the code sent to your phone",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Verification Code",
                hintText: "123456",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Obx(() {
              return _phoneController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () {
                  _phoneController.verifyOtp(_codeController.text.trim());
                },
                child: Text("Verify"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
