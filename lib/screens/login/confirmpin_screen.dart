// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mmoney_lite/models/regpin_model.dart';
import 'package:mmoney_lite/screens/login/loginpin_screen.dart';
import 'package:mmoney_lite/services/manage_preferance.dart';
import 'package:mmoney_lite/widgets/build_background.dart';

import '../../helper/waiting_process.dart';
import '../../services/dio_service.dart';
import '../../utility/myconstant.dart';
import '../../utility/style.dart';
import '../../widgets/build_numberpad.dart';
import '../../widgets/show_alert.dart';

class ConfirmPinScreen extends StatefulWidget {
  const ConfirmPinScreen({super.key, required this.otpCode});

  final String otpCode;

  @override
  State<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends State<ConfirmPinScreen> {
  String text = '';
  String pin = '';
  @override
  Widget build(BuildContext context) {
    return buildBackground(
      widget: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0),
          elevation: 0,
          title: Text(
            'Confirm PIN Code ',
            style: Style.headLineLaoStyle1,
          ),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 0),
            child: IntrinsicHeight(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        height: 150,
                        child: SvgPicture.asset(Style.svgOTP),
                      ),
                    ),
                    Text(
                      // 'ຢືນຢັນ PIN Code ຂອງທ່ານອິກຄັ້ງ.',
                      'Enter your PIN Code again.',
                      style: Style.headLineLaoStyle2,
                    ),
                    const Spacer(),
                    Container(
                      height: 70,
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
                      leftButtonFn: () {
                        print('left button clicked');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
      if (widget.otpCode == text) {
        Future.delayed(MyConstant.delayTime).then((_) {
          _registerPIN(text);
        });
      } else {
        WaitingProcess.hide(context);
        showFailedAlert(
          context,
          'Error',
          'Your pin code doesn\'t match.',
        );
      }
      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil('/main', (Route<dynamic> route) => false);
    }
  }

  Future<Null> _registerPIN(String pincode) async {
    String msisdn = await ManagePreferance().getStringPreferance1('msisdn');
    var url = '${MyConstant.urlAddress}/register';
    var data = {"msisdn": msisdn, "pin": pincode};
    var options = {"mlitekey": MyConstant.mlitekey};
    var res = await DioService.createDio(path: url, body: data, option: options);
    if (res["resultCode"] == 0) {
      WaitingProcess.hide(context);
      ManagePreferance().setStringPreferance('token', res["data"]["token"]);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (c) => const LoginPinScreen()), (route) => false);
    } else {
      WaitingProcess.hide(context);
      showFailedAlert(context, res["resultCode"].toString(), res["resultDesc"].toString());
    }
  }
}
