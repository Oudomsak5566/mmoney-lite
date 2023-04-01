class BallanceModel {
  int? resultCode;
  String? resultDesc;
  Data? data;

  BallanceModel({this.resultCode, this.resultDesc, this.data});

  BallanceModel.fromJson(Map<String, dynamic> json) {
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
  String? resultCode;
  String? resultDesc;
  String? msisdn;
  int? amount;
  String? active;
  String? birthday;
  String? firstname;

  Data(
      {this.resultCode,
      this.resultDesc,
      this.msisdn,
      this.amount,
      this.active,
      this.birthday,
      this.firstname});

  Data.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultDesc = json['resultDesc'];
    msisdn = json['msisdn'];
    amount = json['amount'];
    active = json['active'];
    birthday = json['birthday'];
    firstname = json['firstname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['resultDesc'] = this.resultDesc;
    data['msisdn'] = this.msisdn;
    data['amount'] = this.amount;
    data['active'] = this.active;
    data['birthday'] = this.birthday;
    data['firstname'] = this.firstname;
    return data;
  }
}
