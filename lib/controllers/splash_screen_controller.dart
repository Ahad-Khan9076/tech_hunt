import 'package:get/get.dart';
import '../routes/app_route.dart';


class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(Duration(seconds: 3)); // Wait for 3 seconds
    Get.offNamed(AppRoutes.loginScreen); // Navigate to login screen
  }
}
