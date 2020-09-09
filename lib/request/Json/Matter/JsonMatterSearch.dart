class JsonMatterSearch {
  String sId;
  String title;
  String course;
  String image;

  JsonMatterSearch({this.sId, this.title, this.course, this.image});

  JsonMatterSearch.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['Title'];
    course = json['Course'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Title'] = this.title;
    data['Course'] = this.course;
    data['Image'] = this.image;
    return data;
  }
}
