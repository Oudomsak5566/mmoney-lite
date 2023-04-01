import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mmoney_lite/utility/myconstant.dart';

import '../utility/style.dart';

class buildTextfield extends StatelessWidget {
  const buildTextfield({
    Key? key,
    required this.size,
    required this.labelName,
    required this.controllerName,
    required this.nameTextfield,
    required this.icons,
    required this.isRequire,
  }) : super(key: key);

  final double size;
  final String nameTextfield;
  final String labelName;
  final IconData icons;
  final bool isRequire;

  final TextEditingController controllerName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            labelName,
            style: GoogleFonts.poppins(textStyle: Style.textLaoStyleBlack),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isRequire == true
                ? buildRequireTrue(size: size, nameTextfield: nameTextfield, controllerName: controllerName, icons: icons)
                : buildRequireFalse(size: size, nameTextfield: nameTextfield, controllerName: controllerName, icons: icons)
          ],
        ),
      ],
    );
  }
}

class buildRequireTrue extends StatelessWidget {
  const buildRequireTrue({
    Key? key,
    required this.size,
    required this.nameTextfield,
    required this.controllerName,
    required this.icons,
  }) : super(key: key);

  final double size;
  final String nameTextfield;
  final TextEditingController controllerName;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    double radius = 25;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: size * 0.9,
      child: FormBuilderTextField(
        name: nameTextfield,
        controller: controllerName,
        decoration: InputDecoration(
          // labelText: labelName,
          prefixIcon: Icon(icons, color: Style.textColorBlack),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Style.textColorBlack),
            borderRadius: BorderRadius.circular(radius),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          ),

          //validate error
          errorStyle: GoogleFonts.notoSansLao(color: Style.primary),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Style.primary),
            borderRadius: BorderRadius.circular(radius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Style.primary),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        // autovalidateMode: AutovalidateMode.always,
        validator: FormBuilderValidators.compose([
          FormBuilderValidators.required(),
        ]),
      ),
    );
  }
}

class buildRequireFalse extends StatelessWidget {
  const buildRequireFalse({
    Key? key,
    required this.size,
    required this.nameTextfield,
    required this.controllerName,
    required this.icons,
  }) : super(key: key);

  final double size;
  final String nameTextfield;
  final TextEditingController controllerName;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    double radius = 25;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: size * 0.9,
      child: FormBuilderTextField(
        name: nameTextfield,
        controller: controllerName,
        decoration: InputDecoration(
          // labelText: labelName,
          prefixIcon: Icon(icons, color: Style.textColorBlack),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Style.textColorBlack),
            borderRadius: BorderRadius.circular(radius),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );
  }
}
