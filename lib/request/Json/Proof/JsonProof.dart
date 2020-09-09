class JsonProof {
  String sId;
  String title;
  String image;

  JsonProof({this.sId, this.title, this.image});

  JsonProof.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['Title'];
    image = json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['Title'] = this.title;
    data['Image'] = this.image;
    return data;
  }
}
