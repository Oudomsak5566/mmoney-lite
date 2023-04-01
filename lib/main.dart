// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:mmoney_lite/begin_screen.dart';
import 'package:mmoney_lite/bottomnav_screen.dart';
import 'package:mmoney_lite/providers/electric_provider.dart';
import 'package:mmoney_lite/providers/user_provider.dart';
import 'package:mmoney_lite/screens/electric/electric_provider_screen.dart';
import 'package:mmoney_lite/screens/home/home_screen.dart';
import 'package:mmoney_lite/screens/login/login_screen.dart';
import 'package:mmoney_lite/screens/login/setpin_screen.dart';
import 'package:mmoney_lite/screens/scanqr/scan_screen.dart';
import 'package:mmoney_lite/screens/tvstream/livevideo_screen.dart';
import 'package:mmoney_lite/screens/tvstream/tvlists_screen.dart';
import 'package:mmoney_lite/splash_screen.dart';
import 'package:mmoney_lite/test_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //! Disable Rotate Screen
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => userProvider()),
        ChangeNotifierProvider(create: (_) => electricProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black.withOpacity(0),
          primarySwatch: Colors.red,
        ),
        // initialRoute: '/splash',
        initialRoute: '/test',
        routes: {
          '/test': (context) => LiveVideoScreen(),

          '/splash': (context) => SplashScreen(), // detault page
          '/begin': (context) => BeginScreen(),
          '/login': (context) => LoginScreen(),
          '/bottombar': (context) => BottomNavScreen(),
          '/home': (context) => HomeScreen(),
          // '/otp': (context) => OtpScreen(),
          '/setpin': (context) => SetPinScreen(),
          // '/confirmpin': (context) => ConfirmPinScreen(),
          '/scan': (context) => ScanScreen(),

          '/electricprovider': (context) => ElectricProviderScreen(),

          '/tvlists': (context) => TvListsScreen(),
        },
        //
        //form bulider validated
        supportedLocales: const [Locale('en')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
      ),
    );
  }
}
