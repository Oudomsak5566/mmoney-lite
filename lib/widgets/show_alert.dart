import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utility/style.dart';

void showSuccessAlert(BuildContext context, String title, String desc) async {
  AwesomeDialog(
    context: context,
    animType: AnimType.topSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.success,
    showCloseIcon: true,
    dismissOnTouchOutside: false,
    title: title,
    titleTextStyle: Style.headLineStyle1Black,
    desc: desc,
    descTextStyle: GoogleFonts.lato(),
    btnOkOnPress: () {},
  ).show();
}

void showFailedAlert(BuildContext context, String title, String desc) {
  AwesomeDialog(
    context: context,
    animType: AnimType.topSlide,
    headerAnimationLoop: false,
    dialogType: DialogType.error,
    showCloseIcon: false,
    dismissOnTouchOutside: false,
    btnOkColor: Style.dark,
    title: title,
    titleTextStyle: Style.headLineStyle1Black,
    desc: desc,
    descTextStyle: GoogleFonts.poppins(),
    btnOkOnPress: () {},
  ).show();
}
