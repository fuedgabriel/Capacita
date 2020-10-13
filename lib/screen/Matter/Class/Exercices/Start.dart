import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:Capacita/request/RequestMatter.dart';
import 'package:Capacita/request/Json/Matter/JsonExercises.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Capacita/request/Json/Matter/JsonColector.dart';
// ignore: must_be_immutable
class Start extends StatefulWidget {
  @override
  String title;
  String id;
  Start(this.title, this.id);
  _StartState createState() => _StartState(id);
}
enum SingingCharacter { A, B, C, D, E }

class _StartState extends State<Start> {
  int indexExercices = 0;
  int indexExercicesBuilder = 0;
  Color BottomBarColor = Colors.white;
  String BottomBarText = "Enviar Resposta";
  List<JsonExercises> Exercises;
  String TitlePage = 'Carregando...';
  String Title = 'Carregando...';
  String SubTitle = 'Carregando...';
  String ImageStr = 'Carregando...';
  String TitlePos = 'Carregando...';
  String SubTitlePos = 'Carregando...';
  String A = 'Carregando...';
  String B = 'Carregando...';
  String C = 'Carregando...';
  String D = 'Carregando...';
  String E = 'Carregando...';

  Color MaterialButtonColor = Colors.white;
  Color MaterialButtonColorText = Colors.black.withOpacity(0.5);
  String MaterialButtonText = 'Selecione uma resposta';

  double MaterialButtonElevation = 0;
  IconData MaterialButtonIcon;
  List<JsonColector> Colector;
  Color AnserwA = Colors.white;
  Color AnserwB = Colors.white;
  Color AnserwC = Colors.white;
  Color AnserwD = Colors.white;
  Color AnserwE = Colors.white;


  _StartState(id){
    APIMatter.ExercisesSearch(id).then((response) async{
      Iterable list = json.decode(response.body);
      setState(() {
        Exercises = list.map((model) => JsonExercises.fromJson(model)).toList();
        indexExercices = Exercises.length;
        indexExercicesBuilder = Exercises.length;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();

      APIMatter.SelectorSearch(prefs.getString('_id'), id).then((valor){
        Iterable decode = json.decode(valor.body);
        Colector = decode.map((model) => JsonColector.fromJson(model)).toList();
        setState(() {
          if(Colector.toString() == '[]'){
            indexExercices = 0;
            APIMatter.SelectorInsert(prefs.getString('_id'), id, 0);
          }
          else{
            if(Colector[0].percent == null){
              indexExercices = 0;
            }
            else{
              indexExercices = Colector[0].percent;
            }
          }
          _ChangeText(indexExercices);
        });
      });
    });
  }
  _RenewColector(index) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    APIMatter.SelectorSearch(prefs.getString('_id'), widget.id).then((valor){
      Iterable decode = json.decode(valor.body);
      Colector = decode.map((model) => JsonColector.fromJson(model)).toList();
      if(index >= Colector[0].percent && index <= Exercises.length){
        APIMatter.SelectorUpdate(Colector[0].sId, index);
      }
    });
  }



  SingingCharacter _character;

  _ChangeText(index){
    try {
      setState(() {
        _character = null;
        Title = Exercises[index].title;
        SubTitle = Exercises[index].subTitle;
        ImageStr = Exercises[index].image;
        TitlePos = Exercises[index].titlePos;
        SubTitlePos = Exercises[index].subTitlePos;
        A = Exercises[index].answers[0].s1;
        B = Exercises[index].answers[0].s2;
        C = Exercises[index].answers[0].s3;
        D = Exercises[index].answers[0].s4;
        E = Exercises[index].answers[0].s5;
        AnserwA = Colors.brown;
        AnserwB = Colors.brown;
        AnserwC = Colors.brown;
        AnserwD = Colors.brown;
        AnserwE = Colors.brown;
      });
    } on Exception catch (_) {
      print('_');
    }
  }

  Widget AnswersWidget(Title,SingingCharacter Op, Anserw) {
    if(Title == "" || Title ==null){
      return Container();
    }
    else{
      return ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text(Title, style: TextStyle(
            color: Anserw
        ),),
        leading: Radio(
          value: Op,
          groupValue: _character,
          onChanged: (SingingCharacter value) {
            setState(() {
              _character = value;
//              BottomBarColor = Colors.green[400];
              MaterialButtonColor = Colors.yellow;
              MaterialButtonColorText = Colors.orange;
              MaterialButtonText = 'Enviar resposta  ';
              MaterialButtonElevation = 1;
              MaterialButtonIcon = Icons.send;
            });
          },
        ),
      );
    }
  }

  Widget TitleWidget(Title,) {
    if(Title == "" || Title ==null){
      return Container();
    }
    else{
      return Card(
        margin: EdgeInsets.all(0),
        child: Center(
          child: Text(
            "\n"+Title+"\n",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          )
        ),
      );
    }
  }

  Widget TextWidget(Title,) {
    if(Title == "" || Title ==null){
      return Container();
    }
    else{
      return Card(
        margin: EdgeInsets.all(0),
        child: Center(
          child: Text(
            "\n"+Title+"\n",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16
            ),
          ),
        ),
      );
    }
  }

  Widget ImageWidget(link,) {
    if(link == "" || link ==null){
      return Container();
    }
    else{
      return Image(
          image: NetworkImage(link)
      );
    }
  }
  Widget TitlePosWidget(Title,) {
    if(Title == "" || Title ==null){
      return Container();
    }
    else{
      return Card(
        margin: EdgeInsets.all(0),
        child: Center(
          child: Text(
            "\n"+Title+"\n",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500
            ),
          ),
        ),
      );
    }
  }

  Widget TextPosWidget(Title,) {
    if(Title == "" || Title ==null){
      return Container();
    }
    else{
      return Card(
        margin: EdgeInsets.all(0),
        child: Center(
          child: Text(
            "\n"+Title+"\n",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      bottomNavigationBar: BottomAppBar(
        color: BottomBarColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black.withOpacity(0.5),
              onPressed: (){
                indexExercices = indexExercices-1;
                _ChangeText(indexExercices);
              },
            ),
            MaterialButton(
              elevation:  MaterialButtonElevation,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              color: MaterialButtonColor,
              disabledElevation: MaterialButtonElevation,
              focusElevation: MaterialButtonElevation,
              highlightElevation: MaterialButtonElevation,
              hoverElevation: MaterialButtonElevation,
              child: Row(
                children: <Widget>[
                  Text( MaterialButtonText, style: TextStyle(color:  MaterialButtonColorText),),
                  Icon(MaterialButtonIcon, color: MaterialButtonColorText,)
                ],
              ),
              onPressed: () {
                if(_character == null){

                }
                else if(Exercises[indexExercices].correct-1 == _character.index){
                  showGeneralDialog(
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionBuilder: (context, a1, a2, widget) {
                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                            opacity: a1.value,
                            child: AlertDialog(
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                              title: Text('Parabéns, você acertou a questão.',
                                style: TextStyle(
                                  fontSize: 15.6,
                                  color: Colors.green
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 200),
                      barrierDismissible: true,
                      barrierLabel: '',
                      context: context,
                      pageBuilder: (context, animation1, animation2) {var a; return a; });
                  Future.delayed(Duration(milliseconds: 800), () {
                    Navigator.pop(context);
                  });
                  indexExercices = indexExercices+1;
                  _RenewColector(indexExercices);
                  _ChangeText(indexExercices);
                }else{
                  showGeneralDialog(
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionBuilder: (context, a1, a2, widget) {
                        return AlertDialog(
                          title: Center(child: Text('Poxa, não foi dessa vez.', style: TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 16), )),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children : <Widget>[
                              Expanded(
                                child: Text(
                                  'Deseja tentar novamente?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.green,

                                  ),
                                ),
                              )
                            ],
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Sim',),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Colors.green,
                            ),
                            FlatButton(
                              child: Text('Não'),
                              onPressed: () {
                                setState(() {
                                  if(Exercises[indexExercices].correct == 1){
                                    AnserwA = Colors.yellow;
                                  }else if(Exercises[indexExercices].correct == 2){
                                    AnserwB = Colors.yellow;
                                  }
                                  else if(Exercises[indexExercices].correct == 3){
                                    AnserwC = Colors.yellow;
                                  }else if(Exercises[indexExercices].correct == 4){
                                    AnserwD = Colors.yellow;
                                  }else if(Exercises[indexExercices].correct == 5){
                                    AnserwE = Colors.yellow;
                                  }

                                });
                                Navigator.of(context).pop();
                              },
                              color: Colors.red,
                            )
                          ],
                        );
                      },
                      transitionDuration: Duration(milliseconds: 500),
                      barrierDismissible: true,
                      barrierLabel: '',
                      context: context,
                      pageBuilder: (context, animation1, animation2) {var a; return a; });
                }
              }
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              color: Colors.black.withOpacity(0.5),
              onPressed: (){
                indexExercices = indexExercices+1;
                _RenewColector(indexExercices);
                _ChangeText(indexExercices);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(242, 162, 2, 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(40)),),
          title: Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.15), child: Center(child: Text(widget.title,)),)
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/fundo.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                ),
                height: 50,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: indexExercicesBuilder,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.all(4.0),
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              width: 1,
                              color: Colors.amber[800]
                          ),
                        ),
                        child:  Center(
                            child: Text(
                              index.toString(),
                              style: TextStyle(
                                fontFamily: 'Georgia',
                                color: Colors.brown,
                                fontSize: 28,
                              ),
                            )
                        ),
                      ),
                      onTap: (){
                        indexExercices = index;
                        _ChangeText(index);
                      },
                    );
                  },
                )
            ),
            SizedBox(height: 10,),
            TitleWidget(Title),
            SizedBox(height: 10,),
            Card(
                margin: EdgeInsets.all(0),
                child: TextWidget(SubTitle)
            ),

            SizedBox(height: 10,),
            Card(
              margin: EdgeInsets.all(0),
              color: Colors.white70,
              child: ImageWidget(ImageStr),
            ),
            SizedBox(height: 10,),
            TitlePosWidget(TitlePos),
            SizedBox(height: 10,),
            TextPosWidget(SubTitlePos),
            Divider(),
            AnswersWidget(A, SingingCharacter.A, AnserwA),
            Divider(),
            AnswersWidget(B, SingingCharacter.B, AnserwB),
            Divider(),
            AnswersWidget(C, SingingCharacter.C, AnserwC),
            Divider(),
            AnswersWidget(D, SingingCharacter.D, AnserwD),
            Divider(),
            AnswersWidget(E, SingingCharacter.E, AnserwE),


            Container(
              margin: const EdgeInsets.only(left: 120, right: 120, top: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                    width: 1,
                    color: Colors.amber[800]
                ),
              ),
              child:  Center(
                  child: Text(
                    indexExercices.toString(),
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      color: Colors.brown,
                      fontSize: 28,
                    ),
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
