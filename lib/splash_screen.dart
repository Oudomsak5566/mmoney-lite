// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:mmoney_lite/begin_screen.dart';
import 'package:mmoney_lite/screens/login/loginpin_screen.dart';
import 'package:mmoney_lite/services/manage_preferance.dart';
import 'package:mmoney_lite/widgets/build_background.dart';

import 'utility/style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: timeDilation.ceil() * 1000)).then((_) {
      _routeService();
    });
  }

  // check shared perferance login
  //***************************************************************** */
  Future<void> _routeService() async {
    String token = await ManagePreferance().getStringPreferance1('token');
    // String token = "";
    print('token ===> $token');

    if (token.isEmpty) {
      print('===> route Begin Screen');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BeginScreen(),
        ),
      );
    } else {
      print('===> route Login by PIN');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPinScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildBackground(
      widget: Scaffold(
        backgroundColor: Colors.red.withOpacity(0),
        body: Center(child: SizedBox(height: 100, width: 100, child: Image.asset(Style.imgLoadingLogo))),
      ),
    );
  }
}
