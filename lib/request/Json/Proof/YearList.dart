class JsonYearList {
  String sId;
  int title;
  String course;
  String link;

  JsonYearList({this.sId, this.title, this.course, this.link});

  JsonYearList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['Title'];
    course = json['Course'];
    link = json['Link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Title'] = this.title;
    data['Course'] = this.course;
    data['Link'] = this.link;
    return data;
  }
}
