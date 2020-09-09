class JsonExercises {
  List<Answers> answers;
  String sId;
  String title;
  String subTitle;
  String image;
  String titlePos;
  String subTitlePos;
  int correct;
  String questions;

  JsonExercises(
      {this.answers,
        this.sId,
        this.title,
        this.subTitle,
        this.image,
        this.titlePos,
        this.subTitlePos,
        this.correct,
        this.questions});

  JsonExercises.fromJson(Map<String, dynamic> json) {
    if (json['Answers'] != null) {
      answers = new List<Answers>();
      json['Answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
    sId = json['_id'];
    title = json['Title'];
    subTitle = json['SubTitle'];
    image = json['Image'];
    titlePos = json['TitlePos'];
    subTitlePos = json['SubTitlePos'];
    correct = json['Correct'];
    questions = json['Questions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.answers != null) {
      data['Answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['Title'] = this.title;
    data['SubTitle'] = this.subTitle;
    data['Image'] = this.image;
    data['TitlePos'] = this.titlePos;
    data['SubTitlePos'] = this.subTitlePos;
    data['Correct'] = this.correct;
    data['Questions'] = this.questions;
    return data;
  }
}

class Answers {
  String s1;
  String s2;
  String s3;
  String s4;
  String s5;

  Answers({this.s1, this.s2, this.s3, this.s4, this.s5});

  Answers.fromJson(Map<String, dynamic> json) {
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    s4 = json['4'];
    s5 = json['5'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['4'] = this.s4;
    data['5'] = this.s5;
    return data;
  }
}
