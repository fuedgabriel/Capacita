class JsonQuestion {
  String sId;
  String title;
  String image;
  String matter;

  JsonQuestion({this.sId, this.title, this.image, this.matter});

  JsonQuestion.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['Title'];
    image = json['Image'];
    matter = json['Matter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Title'] = this.title;
    data['Image'] = this.image;
    data['Matter'] = this.matter;
    return data;
  }
}
