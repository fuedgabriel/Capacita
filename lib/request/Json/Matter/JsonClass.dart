class JsonClass {
  String sId;
  String title;
  String link;
  String doc;
  String matter;

  JsonClass({this.sId, this.title, this.link, this.doc, this.matter});

  JsonClass.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['Title'];
    link = json['Link'];
    doc = json['Doc'];
    matter = json['Matter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Title'] = this.title;
    data['Link'] = this.link;
    data['Doc'] = this.doc;
    data['Matter'] = this.matter;
    return data;
  }
}
