import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'routes/app_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      getPages: [
        GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
        GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
        GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),
        GetPage(name: AppRoutes.signupScreen, page: () => SignupScreen()),
        GetPage(name: AppRoutes.forgotPasswordScreen, page: () => ForgotPasswordScreen()),
      ],
    );
  }
}
