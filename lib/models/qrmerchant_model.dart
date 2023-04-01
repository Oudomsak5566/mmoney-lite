class QrMerchantModel {
  int? resultCode;
  String? resultDesc;
  Data? data;

  QrMerchantModel({this.resultCode, this.resultDesc, this.data});

  QrMerchantModel.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultDesc = json['resultDesc'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['resultDesc'] = this.resultDesc;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? qrType;
  String? shopName;
  String? merchantName;
  String? merchantMobile;
  String? transAmount;
  String? fee;

  Data({this.qrType, this.shopName, this.merchantName, this.merchantMobile, this.transAmount, this.fee});

  Data.fromJson(Map<String, dynamic> json) {
    qrType = json['qrType'];
    shopName = json['shopName'];
    merchantName = json['merchantName'];
    merchantMobile = json['merchantMobile'];
    transAmount = json['transAmount'];
    fee = json['fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qrType'] = this.qrType;
    data['shopName'] = this.shopName;
    data['merchantName'] = this.merchantName;
    data['merchantMobile'] = this.merchantMobile;
    data['transAmount'] = this.transAmount;
    data['fee'] = this.fee;
    return data;
  }
}
