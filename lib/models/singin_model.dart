class SinginModel {
  int? resultCode;
  String? resultDesc;
  Data? data;

  SinginModel({this.resultCode, this.resultDesc, this.data});

  SinginModel.fromJson(Map<String, dynamic> json) {
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
  String? msisdn;
  String? ref;
  int? id;

  Data({this.msisdn, this.ref, this.id});

  Data.fromJson(Map<String, dynamic> json) {
    msisdn = json['msisdn'];
    ref = json['ref'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msisdn'] = this.msisdn;
    data['ref'] = this.ref;
    data['id'] = this.id;
    return data;
  }
}
