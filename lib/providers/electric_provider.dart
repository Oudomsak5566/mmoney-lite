// ignore_for_file: camel_case_types

import 'package:flutter/foundation.dart';

class electricProvider extends ChangeNotifier {
  String _title = '';
  String _code = '';
  int _eWid = 0;
  int _debit = 0;
  String _remarkNote = '';

  String get title => _title;
  String get code => _code;
  int get eWid => _eWid;
  int get debit => _debit;
  String get remarkNote => _remarkNote;

  void setTitle(String value) {
    _title = value;
    notifyListeners();
  }

  void setCode(String value) {
    _code = value;
    notifyListeners();
  }

  void setEwid(int value) {
    _eWid = value;
    notifyListeners();
  }

  void setDebit(int value) {
    _debit = value;
    notifyListeners();
  }

  void setRemarkNote(String value) {
    _remarkNote = remarkNote;
    notifyListeners();
  }
}
