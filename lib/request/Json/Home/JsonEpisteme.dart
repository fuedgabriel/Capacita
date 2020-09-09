class JsonEpisteme {
  String sId;
  String title;
  String link;
  String image;
  int type;

  JsonEpisteme({this.sId, this.title, this.link, this.image, this.type});

  JsonEpisteme.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['Title'];
    link = json['Link'];
    image = json['Image'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Title'] = this.title;
    data['Link'] = this.link;
    data['Image'] = this.image;
    data['Type'] = this.type;
    return data;
  }
}
