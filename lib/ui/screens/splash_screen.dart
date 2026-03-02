import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';
import 'package:task_manager/ui/screens/main_bottom_nav_screen.dart';

import '../widget/body_background.dart';
import 'login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

//=====================
  @override
  void initState(){
    super.initState();
    goToLogin();
  }
//=====================

//-------------

    Future<void> goToLogin() async {
    final bool isLoggedIn = await AuthController.checkAuthState();



    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');


    Future.delayed(const Duration(seconds: 2)).then((value) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(
              builder: (context) => isLoggedIn
              ? const MainBottomNavScreen(): const LoginScreen()),
              (
              route) => false);
    });
  }
//-------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyBackground(
        child: Center(
          child: SvgPicture.asset(
            "assets/images/logo.svg",
            width: 200,
          ),
        ),
      ),
    );
  }
}