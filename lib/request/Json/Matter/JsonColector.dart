class JsonColector {
  String sId;
  String user;
  String question;
  int percent;

  JsonColector({this.sId, this.user, this.question, this.percent});

  JsonColector.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['User'];
    question = json['Question'];
    percent = json['Percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['User'] = this.user;
    data['Question'] = this.question;
    data['Percent'] = this.percent;
    return data;
  }
}
