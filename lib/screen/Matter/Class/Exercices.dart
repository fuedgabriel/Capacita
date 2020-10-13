import 'dart:convert';
import 'package:Capacita/request/Json/Matter/JsonColector.dart';
import 'package:Capacita/request/Json/Matter/JsonExercises.dart';
import '../../Widget/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Exercices/Start.dart';
import 'package:Capacita/request/RequestMatter.dart';
import 'package:Capacita/request/Json/Matter/JsonQuestion.dart';

class Exercices extends StatefulWidget {
  final String id;
  final String title;
  Exercices(this.id, this.title);
  @override
  _ExercicesState createState() => _ExercicesState();
}


class _ExercicesState extends State<Exercices> {
  List<JsonQuestion> search;
  buildContainer() {
    return Container(
        child: FutureBuilder(
            future: APIMatter.QuestionSearch(widget.id).then((response){
              setState(() {
                Iterable list = json.decode(response.body);
                search = list.map((model) => JsonQuestion.fromJson(model)).toList();
              });
              return search;
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing:0,),
                    scrollDirection: Axis.vertical,
                    itemCount: search.length,
                    padding: EdgeInsets.only(left: 2, top: 10),
                    itemBuilder: (context, index) {
                      return Center(
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.33,
                              height: 130,

                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                ),
                                child: Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          stops: [
                                            0.1,
                                            0.4,
                                            0.5,
                                            0.9
                                          ],
                                          colors: [
                                            Color.fromRGBO(242, 162, 2, 1),
                                            Color.fromRGBO(242, 162, 2, 1),
                                            Color.fromRGBO(242, 162, 2, 1),
                                            Color.fromRGBO(14, 91, 255, 1)
                                          ])
                                  ),
                                  child: GestureDetector(
                                    child: ListView(
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.only(top: 10),
                                      children: <Widget>[
                                        Image(
                                          image: NetworkImage(search[index].image),
                                          fit: BoxFit.scaleDown,
                                          height: 80,
                                        ),
                                        Padding(padding: EdgeInsets.only(top: 4),),
                                        Center(
                                          child: Text(
                                            search[index].title,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    onTap: ()async{
                                      List<JsonColector> Colector;
                                      List<JsonExercises> Exercises;
                                      int indexExercices = 0;

                                      double percent = 0.0;
                                      String percentText = '%';
                                      SharedPreferences prefs = await SharedPreferences.getInstance();

                                      APIMatter.SelectorSearch(prefs.getString('_id'), search[index].sId).then((valor){
                                        Iterable decode = json.decode(valor.body);
                                        Colector = decode.map((model) => JsonColector.fromJson(model)).toList();
                                        setState(() {
                                          if(Colector.toString() == '[]'){
                                            indexExercices = 0;
                                          }
                                          else{
                                            if(Colector[0].percent == null){
                                              indexExercices = 0;
                                            }
                                            else{
                                              indexExercices = Colector[0].percent;
                                            }
                                          }
                                          APIMatter.ExercisesSearch(search[index].sId).then((response) async{
                                            Iterable list = json.decode(response.body);
                                            setState(() {
                                              Exercises = list.map((model) => JsonExercises.fromJson(model)).toList();
                                              if(Colector.toString() == '[]'|| Colector == null){
                                                percent = 0.0;
                                              }else{
                                                percent = Colector[0].percent/Exercises.length;
                                              }
                                              percentText = '%';
                                              percentText = (percent*100).toString()+percentText;
                                              if(percentText == "NaN%"){
                                                percentText = "0%";
                                                percent = 0;
                                              }
                                              print(percentText);
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => NetworkGiffyDialog(
                                                    image: ListView(
                                                      padding: EdgeInsets.all(18),
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets.all(10),
                                                          child: Text(
                                                            'Seu Progresso',
                                                            textAlign: TextAlign.center,
                                                            style: TextStyle(
                                                                fontSize: 22.0, fontWeight: FontWeight.w600),
                                                          ),
                                                        ),
                                                        CircularPercentIndicator(
                                                          radius: 120.0,
                                                          lineWidth: 13.0,
                                                          animation: true,
                                                          percent: percent,
                                                          center: Text(
                                                            percentText.replaceRange(2, (percent.toString().length-1), ''),
                                                            style:
                                                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                                                          ),
                                                          circularStrokeCap: CircularStrokeCap.round,
                                                          progressColor: Colors.orange,
                                                        ),
                                                      ],
                                                    ),
                                                    entryAnimation: EntryAnimation.BOTTOM,
                                                    title: Text(
                                                        ''
                                                    ),
                                                    buttonOkText: Text(
                                                      'Iniciar',
                                                      style: TextStyle(
                                                          color: Colors.white
                                                      ),
                                                    ),
                                                    onOkButtonPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Start(search[index].title, search[index].sId)));

                                                    },
                                                  ));
                                            });
                                          });
                                        });
                                      });

                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.25),
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
        child: buildContainer(),
      ),
    );
  }
}
