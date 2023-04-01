// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mmoney_lite/begin_screen.dart';
import 'package:mmoney_lite/providers/user_provider.dart';
import 'package:mmoney_lite/screens/login/login_screen.dart';
import 'package:mmoney_lite/services/dio_service.dart';
import 'package:mmoney_lite/services/manage_preferance.dart';
import 'package:mmoney_lite/widgets/build_background.dart';
import 'package:provider/provider.dart';

import '../../helper/waiting_process.dart';
import '../../utility/myconstant.dart';
import '../../utility/style.dart';
import '../../widgets/build_numberpad.dart';
import '../../widgets/show_alert.dart';

class LoginPinScreen extends StatefulWidget {
  const LoginPinScreen({super.key});

  @override
  State<LoginPinScreen> createState() => _LoginPinScreenState();
}

class _LoginPinScreenState extends State<LoginPinScreen> {
  String text = '';
  String pin = '';
  String msisdn = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPreferance();
  }

  Future<void> _loadPreferance() async {
    msisdn = await ManagePreferance().getStringPreferance1('msisdn');
    context.read<userProvider>().setWalletID(msisdn);
    setState(() {
      msisdn;
    });
    if (msisdn == 'null') {
      ManagePreferance().removeUser();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BeginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildBackground(
      widget: Scaffold(
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 0),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  buildHeader(),
                  const SizedBox(height: 20),
                  buildOptionMenu(),
                  const Spacer(),
                  Container(
                    height: 100,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          pin,
                          style: GoogleFonts.poppins(fontSize: 45, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  NumericKeyboard(
                    onKeyboardTap: _onKeyboardTap,
                    textColor: Style.dark,
                    rightButtonFn: () {
                      if (text.isNotEmpty) {
                        setState(() {
                          text = text.substring(0, text.length - 1);
                          pin = pin.substring(0, pin.length - 1);
                        });
                      }
                    },
                    rightIcon: const Icon(
                      Iconsax.arrow_square_left,
                      color: Colors.white,
                      size: 45,
                    ),
                    leftButtonFn: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      //   Column(
      //     children: [
      //       buildHeader(),
      //       const SizedBox(height: 20),
      //       buildOptionMenu(),
      //       const Spacer(),
      //       Container(
      //         height: 100,
      //         width: double.infinity,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Text(
      //               pin,
      //               style: GoogleFonts.poppins(fontSize: 45, color: Colors.white),
      //             ),
      //           ],
      //         ),
      //       ),
      //       NumericKeyboard(
      //         onKeyboardTap: _onKeyboardTap,
      //         textColor: MyConstant.dark,
      //         rightButtonFn: () {
      //           if (text.isNotEmpty) {
      //             setState(() {
      //               text = text.substring(0, text.length - 1);
      //               pin = pin.substring(0, pin.length - 1);
      //             });
      //           }
      //         },
      //         rightIcon: const Icon(
      //           Iconsax.arrow_square_left,
      //           color: Colors.white,
      //           size: 45,
      //         ),
      //         leftButtonFn: () {},
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Padding buildOptionMenu() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              child: Glassmorphism(
                blur: 1,
                opacity: 0.4,
                radius: 10,
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.convert_card, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        'ປ່ຽນກະເປົ໋າເງິນ',
                        style: Style.textLaoStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                WaitingProcess.show(context);
                Future.delayed(MyConstant.delayTime).then((_) {
                  _fotgotPIN();
                });
              },
              child: Glassmorphism(
                blur: 1,
                opacity: 0.4,
                radius: 10,
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Iconsax.refresh, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        'ລືມລະຫັດ PIN',
                        style: Style.textLaoStyle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container buildHeader() {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        image: const DecorationImage(
          image: AssetImage('images/bg.jpg'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.8),
            blurRadius: 100,
            spreadRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 3.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 55),
              const Icon(
                Iconsax.empty_wallet,
                color: Colors.white,
                size: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Wallet Account',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                context.watch<userProvider>().walletId,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _onKeyboardTap(String value) {
    if (text.length <= 5) {
      setState(() {
        text = text + value;
        pin = pin + '✱';
      });
    }
    if (text.length == 6) {
      WaitingProcess.show(context);
      Future.delayed(MyConstant.delayTime).then((_) {
        _loginPIN(text);
      });
    }
  }

  Future<void> _fotgotPIN() async {
    ManagePreferance().removeUser();
    var url = '${MyConstant.urlAddress}/delete';
    var data = {"msisdn": msisdn};
    var options = {"mlitekey": MyConstant.mlitekey};
    var res = await DioService.createDio(path: url, body: data, option: options);
    if (res["resultCode"] == 0) {
      WaitingProcess.hide(context);
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (BuildContext context) => const BeginScreen()), ModalRoute.withName('/'));
    } else {
      WaitingProcess.hide(context);
      showFailedAlert(context, res["resultCode"], res["resultDesc"]);
    }
  }

  Future _loginPIN(String pincode) async {
    var url = '${MyConstant.urlAddress}/login';
    var data = {"msisdn": msisdn, "pin": pincode};
    var options = {"mlitekey": MyConstant.mlitekey};
    var res = await DioService.createDio(path: url, body: data, option: options);
    if (res["resultCode"] == 0) {
      WaitingProcess.hide(context);
      Navigator.pushNamedAndRemoveUntil(context, '/bottombar', ModalRoute.withName('/bottombar'));
    } else {
      WaitingProcess.hide(context);
      showFailedAlert(context, res["resultCode"], res["resultDesc"]);
    }
  }
}

// Future _getQRtoken() async {
  // final Map<String, dynamic> getToketData = {
  //   'username': QrUrl.username,
  //   'password': QrUrl.password,
  //   'grant_type': QrUrl.granttype
  // };
  // Response response = await Dio().post(
  //   QrUrl.getQRToken,
  //   data: getToketData,
  //   options: Options(
  //     headers: {
  //       "Content-Type": "application/x-www-form-urlencoded",
  //     },
  //   ),
  // );
  // ManagePreferance().setStringPreferance('accessToken', response.data["accessToken"]);
  // print('res accessToken ===> ${response.data["accessToken"]}');
// }
