class ElectricRecentAccModel {
  String? accNo;
  String? accName;

  ElectricRecentAccModel({this.accNo, this.accName});

  ElectricRecentAccModel.fromJson(Map<String, dynamic> json) {
    accNo = json['AccNo'];
    accName = json['AccName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AccNo'] = this.accNo;
    data['AccName'] = this.accName;
    return data;
  }
}
