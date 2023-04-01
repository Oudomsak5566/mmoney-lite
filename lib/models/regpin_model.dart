class RegPinModel {
  int? resultCode;
  String? resultDesc;
  Data? data;

  RegPinModel({this.resultCode, this.resultDesc, this.data});

  RegPinModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? msisdn;
  String? pin;
  String? status;
  String? created;
  String? token;

  Data({this.id, this.msisdn, this.pin, this.status, this.created, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    msisdn = json['msisdn'];
    pin = json['pin'];
    status = json['status'];
    created = json['created'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['msisdn'] = this.msisdn;
    data['pin'] = this.pin;
    data['status'] = this.status;
    data['created'] = this.created;
    data['token'] = this.token;
    return data;
  }
}
