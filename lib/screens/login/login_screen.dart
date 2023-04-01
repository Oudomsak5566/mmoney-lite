// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mmoney_lite/helper/app_layout.dart';
import 'package:mmoney_lite/screens/login/otp_screen.dart';
import 'package:mmoney_lite/services/manage_preferance.dart';
import 'package:mmoney_lite/utility/myconstant.dart';
import 'package:mmoney_lite/widgets/build_background.dart';
import 'package:intl/intl.dart';

import '../../helper/waiting_process.dart';
import '../../services/dio_service.dart';
import '../../utility/style.dart';
import '../../widgets/show_alert.dart';
import '../../widgets/show_sheet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  DateTime dateTime = DateTime.now();
  //text controller
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final _msisdn = TextEditingController();
  final _birthday = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return buildBackground(
      widget: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black.withOpacity(0),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: [
                        buildLogoMmoney(),
                        const SizedBox(height: 30),
                        Expanded(
                          child: Container(
                            width: AppLayout.getScreenWidth(),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: FormBuilder(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    buildTitleWelcomText(),
                                    const SizedBox(height: 20),
                                    buildTelephoneInput(),
                                    buildBirthdayInput(),
                                    const Spacer(),
                                    const SizedBox(height: 50),
                                    Container(
                                      height: 60,
                                      width: AppLayout.getScreenWidth() * 0.9,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          _formKey.currentState!.save();
                                          if (_formKey.currentState!.validate()) {
                                            WaitingProcess.show(context);
                                            Future.delayed(MyConstant.delayTime).then((_) {
                                              _loginProcess();
                                            });
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Style.dark,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Next', style: Style.headLineLaoStyle2),
                                            const Icon(Iconsax.arrow_right_3)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Column buildTitleWelcomText() {
    return Column(
      children: [
        Text(
          'Welcome',
          style: Style.headLineStyle1Black,
        ),
        Text(
          'Sing into your digital wallet.',
          style: Style.textLaoStyleBlack,
        ),
      ],
    );
  }

  Row buildLogoMmoney() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 150, width: 150, child: SvgPicture.asset('images/logo_mmoney1.svg')),
      ],
    );
  }

  Column buildTelephoneInput() {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Wallet ID',
                style: Style.textLaoStyleBlack,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: AppLayout.getScreenWidth() * 0.9,
              child: FormBuilderTextField(
                name: 'msisdn',
                controller: _msisdn,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.mobile),
                  enabledBorder: Style.outlineInputBorder(),
                  focusedBorder: Style().focusOutlineInputBorder(),
                  errorBorder: Style().errOutlineInputBorder(),
                  focusedErrorBorder: Style().errOutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.maxLength(10),
                    FormBuilderValidators.minLength(10),
                    FormBuilderValidators.numeric(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column buildBirthdayInput() {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Birthday',
                style: Style.textLaoStyleBlack,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: AppLayout.getScreenWidth() * 0.9,
              child: FormBuilderTextField(
                name: 'birthday',
                controller: _birthday,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Iconsax.gift),
                  enabledBorder: Style.outlineInputBorder(),
                  focusedBorder: Style().focusOutlineInputBorder(),
                  errorBorder: Style().errOutlineInputBorder(),
                  focusedErrorBorder: Style().errOutlineInputBorder(),
                ),
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                  ],
                ),
                readOnly: true,
                onTap: () => showSheet(
                  context,
                  child: buildDatePicker(),
                  onClicked: () {
                    final value = DateFormat('yyyy-MM-dd').format(dateTime);
                    _birthday.text = value;
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDatePicker() => SizedBox(
        height: 250,
        child: CupertinoDatePicker(
          minimumYear: 1960,
          maximumYear: DateTime.now().year,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) => setState(() => this.dateTime = dateTime),
        ),
      );

  Future _loginProcess() async {
    var msisdn = _msisdn.text.trim();
    var birthday = _birthday.text.trim();
    var url = '${MyConstant.urlAddress}/signup';
    var data = {'msisdn': msisdn, 'birthday': birthday};
    var options = {"mlitekey": MyConstant.mlitekey};
    var res = await DioService.createDio(path: url, body: data, option: options);
    if (res["resultCode"] == 0) {
      WaitingProcess.hide(context);
      ManagePreferance().setStringPreferance('msisdn', msisdn);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OtpScreen(msisdn: msisdn, refCode: res["data"]["ref"].toString())));
    } else {
      WaitingProcess.hide(context);
      showFailedAlert(context, res["resultCode"].toString(), res["resultDesc"].toString());
    }
  }
}
