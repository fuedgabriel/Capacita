class JsonLive {
  String title;
  String theme;
  String time;
  String image;
  String link;

  JsonLive({this.title, this.theme, this.time, this.image, this.link});

  JsonLive.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    theme = json['Theme'];
    time = json['Time'];
    image = json['Image'];
    link = json['Link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Theme'] = this.theme;
    data['Time'] = this.time;
    data['Image'] = this.image;
    data['Link'] = this.link;
    return data;
  }
}
