class providerModel {
  String? code;
  String? title;
  int? eWid;

  providerModel({this.code, this.title, this.eWid});

  providerModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    title = json['Title'];
    eWid = json['EWid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Code'] = this.code;
    data['Title'] = this.title;
    data['EWid'] = this.eWid;
    return data;
  }
}
