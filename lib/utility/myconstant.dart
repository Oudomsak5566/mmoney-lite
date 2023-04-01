import 'package:flutter/scheduler.dart';

class MyConstant {
  // static String urlAddress = 'http://172.28.14.87:1337';
  // static String urlAddress = 'http://172.28.12.204:1337';
  static String urlAddress = 'https://vendor.mmoney.la';
  static String desRoute = 'UAT';
  static String mlitekey =
      'gUkXp2r5u8x/A?D(G+KbPeShVmYq3t6v9y\$B&E)H@McQfTjWnZr4u7x!z%C*F-JaNdRgUkXp2s5v8y/B?D(G+KbPeShVmYq3t6w9z\$C&F)H@McQfTjWnZr4u7x!A%D*G';
  static int connectTimeout = 10000;

  static Duration get delayTime =>
      // Duration(milliseconds: timeDilation.ceil() * 100);
      Duration(milliseconds: timeDilation.ceil() * 100);
}
