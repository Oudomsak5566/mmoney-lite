// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmoney_lite/screens/login/loginpin_screen.dart';
import 'package:mmoney_lite/screens/login/setpin_screen.dart';
import 'package:mmoney_lite/utility/myconstant.dart';
import 'package:mmoney_lite/widgets/build_background.dart';
import 'package:pinput/pinput.dart';

import '../../helper/waiting_process.dart';
import '../../utility/style.dart';
import '../../widgets/show_alert.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.msisdn,
    required this.refCode,
  });

  final String msisdn;
  final String refCode;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const length = 6;
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: GoogleFonts.lato(
        fontWeight: FontWeight.bold,
        fontSize: 26,
        color: Style.dark,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Style.dark),
      ),
    );

    return buildBackground(
      widget: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Vertify OTP',
            style: Style.headLineStyle1,
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    // // buildImage(size),
                    Container(height: 150, width: 150, child: Image.asset(Style.imgOTP)),

                    Text(
                      'Verification',
                      style: Style.headLineStyle1,
                    ),
                    Text(
                      'Code sent to the number ${widget.msisdn}',
                      style: Style.textStyle,
                    ),
                    Text(
                      'refCode : ${widget.refCode}',
                      style: Style.textStyle,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      child: Pinput(
                        length: length,
                        controller: controller,
                        focusNode: focusNode,
                        defaultPinTheme: defaultPinTheme,
                        onCompleted: (pin) {
                          WaitingProcess.show(context);
                          Future.delayed(MyConstant.delayTime).then((_) {
                            _otpProcess(pin);
                          });
                        },
                        focusedPinTheme: defaultPinTheme.copyWith(
                          height: 70,
                          width: 50,
                          decoration: defaultPinTheme.decoration!.copyWith(
                            border: Border.all(color: Style.dark),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  style: Style.textStyle,
                                  text: 'Din\'t receive the vertification code? ',
                                ),
                                TextSpan(
                                  text: 'Resend again.',
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 16,
                                    // decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = () async {},
                                ),
                              ],
                            ),
                          ),
                          // Text(
                          //   'Request OTP code again.',
                          //   style: MyConstant.textStyle,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _otpProcess(String otpCode) async {
    var url = '${MyConstant.urlAddress}/confirmOTP';
    Response response;
    var dio = Dio();
    dio.options.connectTimeout = MyConstant.connectTimeout;
    try {
      response = await dio.post(
        url,
        data: {
          "otp": otpCode,
          "ref": widget.refCode,
        },
      );
      print('### check OTP  ===> ${response.data}');
      if (response.data['resultCode'] == 0) {
        // Have a pin code yet?
        response = await dio.post(
          '${MyConstant.urlAddress}/verify',
          data: {
            "msisdn": widget.msisdn,
          },
        );
        print('### res check have pincode  ===> ${response.data}');
        //have pincode go to login by pin
        if (response.data['resultCode'] == 0) {
          print('### success');
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPinScreen()));
        }
        //don't have pincode go to setup pin
        else {
          print('### fail');
          WaitingProcess.hide(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SetPinScreen()));
        }
      } else {
        WaitingProcess.hide(context);
        showFailedAlert(
          context,
          'Error',
          response.data['resultDesc'],
        );
      }
    } on DioError catch (e) {
      WaitingProcess.hide(context);
      showFailedAlert(
        context,
        'Exception Error',
        e.message,
      );
    }
  }
}
