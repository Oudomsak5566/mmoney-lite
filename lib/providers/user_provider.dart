import 'package:flutter/foundation.dart';

class userProvider extends ChangeNotifier {
  String _walletId = '';
  String _walletName = '';
  int _balanceAmount = 0;

  String get walletId => _walletId;
  String get walletName => _walletName;
  int get balanceAmount => _balanceAmount;

  void setWalletID(String value) {
    _walletId = value;
    notifyListeners();
  }

  void setWalletName(String value) {
    _walletName = value;
    notifyListeners();
  }

  void setBalanceAmount(int value) {
    _balanceAmount = value;
    notifyListeners();
  }
}
