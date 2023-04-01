// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mmoney_lite/screens/login/confirmpin_screen.dart';
import 'package:mmoney_lite/widgets/build_background.dart';

import '../../helper/waiting_process.dart';
import '../../utility/myconstant.dart';
import '../../utility/style.dart';
import '../../widgets/build_numberpad.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  State<SetPinScreen> createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  String text = '';
  String pin = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildBackground(
      widget: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Setup PIN Code',
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
                      // 'ລະບຸລະຫັດ PIN Code ຂອງທ່ານ',
                      'Create your new PIN code.',
                      style: Style.headLineLaoStyle2,
                    ),
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
      Future.delayed(MyConstant.delayTime).then((_) {
        WaitingProcess.hide(context);
        Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ConfirmPinScreen(
                otpCode: text,
              ),
            ));
      });
    }
  }
}
