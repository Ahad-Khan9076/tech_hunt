import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/buyer_screen.dart';
import 'screens/seller_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/phone_input_screen.dart';
import 'screens/verification_screen.dart';
import 'routes/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        GetPage(name: AppRoutes.signupScreen, page: () => SignupScreen()),
        GetPage(name: AppRoutes.forgotPasswordScreen, page: () => ForgotPasswordScreen()),
        GetPage(name: AppRoutes.buyerScreen, page: () => BuyerScreen()),
        GetPage(name: AppRoutes.sellerScreen, page: () => SellerScreen()),
        GetPage(name: AppRoutes.adminScreen, page: () => AdminScreen()),
        GetPage(name: AppRoutes.phoneInputScreen, page: () => PhoneInputScreen()),
        GetPage(name: AppRoutes.verificationScreen, page: () => VerificationScreen()),
      ],
    );
  }
}
