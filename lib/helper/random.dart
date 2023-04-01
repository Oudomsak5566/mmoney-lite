// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class randomNumber {
  String? ranNumber;

  String fucRandomNumber() {
    var rng = Random();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyyMMddHHmmss').format(now);
    String value = formattedDate + rng.nextInt(999999).toString();
    return value;
  }
}
