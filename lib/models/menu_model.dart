class MenuModel {
  int? id;
  String? title;
  List<Menulists>? menulists;

  MenuModel({this.id, this.title, this.menulists});

  MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['menulists'] != null) {
      menulists = <Menulists>[];
      json['menulists'].forEach((v) {
        menulists!.add(new Menulists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.menulists != null) {
      data['menulists'] = this.menulists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menulists {
  int? menuid;
  String? title;
  String? route;
  String? svgpicture;

  Menulists({this.menuid, this.title, this.route, this.svgpicture});

  Menulists.fromJson(Map<String, dynamic> json) {
    menuid = json['menuid'];
    title = json['title'];
    route = json['route'];
    svgpicture = json['svgpicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menuid'] = this.menuid;
    data['title'] = this.title;
    data['route'] = this.route;
    data['svgpicture'] = this.svgpicture;
    return data;
  }
}
