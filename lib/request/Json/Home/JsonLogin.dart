class JsonLogin {
//  List<Courser> courser;
  String sId;
  String name;
  String email;
  String password;
  String matricula;

  JsonLogin({
//      {this.courser,
        this.sId,
        this.name,
        this.email,
        this.password,
        this.matricula});

  JsonLogin.fromJson(Map<String, dynamic> json) {
//    if (json['Courser'] != null) {
//      courser = new List<Courser>();
//      json['Courser'].forEach((v) {
//        courser.add(new Courser.fromJson(v));
//      });
//    }
    sId = json['_id'];
    name = json['Name'];
    email = json['Email'];
    password = json['Password'];
    matricula = json['Matricula'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.courser != null) {
//      data['Courser'] = this.courser.map((v) => v.toJson()).toList();
//    }
    data['_id'] = this.sId;
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['Password'] = this.password;
    data['Matricula'] = this.matricula;
    return data;
  }
}

//class Courser {
//  String s1;
//  String s2;
//  String s3;
//  String s4;
//  String s5;
//
//  Courser({this.s1, this.s2, this.s3, this.s4, this.s5});
//
//  Courser.fromJson(Map<String, dynamic> json) {
//    s1 = json['1'];
//    s2 = json['2'];
//    s3 = json['3'];
//    s4 = json['4'];
//    s5 = json['5'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['1'] = this.s1;
//    data['2'] = this.s2;
//    data['3'] = this.s3;
//    data['4'] = this.s4;
//    data['5'] = this.s5;
//    return data;
//  }
//}
