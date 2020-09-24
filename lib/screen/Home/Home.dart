import 'dart:convert';

import '../../request/RequestHome.dart';
import 'package:flutter/material.dart';
import 'widgets/card.dart';
import '../../request/Json/Home/JsonEpisteme.dart';
class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  // ignore: non_constant_identifier_names
  List Names = ["Introdução: funções e estratégias", "Ciclo da água e seus impactos", "Reações que consomem ou liberam"];
  // ignore: non_constant_identifier_names
  List ImageZero = [];
  // ignore: non_constant_identifier_names
  List TitleZero = [];
  // ignore: non_constant_identifier_names
  List LinkZero = [];
  // ignore: non_constant_identifier_names
  List ImageOne = [];
  // ignore: non_constant_identifier_names
  List TitleOne = [];
  // ignore: non_constant_identifier_names
  List LinkOne = [];
  // ignore: non_constant_identifier_names
  List ImageTwo = [];
  // ignore: non_constant_identifier_names
  List TitleTwo = [];
  // ignore: non_constant_identifier_names
  List LinkTwo = [];


  _Home(){
    API.Episteme(0).then((response){
      setState(() {
        print(response.body);
        Iterable listZero = json.decode(response.body);
        // ignore: non_constant_identifier_names
        List<JsonEpisteme> EspitemeZero = listZero.map((model) => JsonEpisteme.fromJson(model)).toList();
        ImageZero.addAll(EspitemeZero.map((f) => f.image).toList());
        TitleZero.addAll(EspitemeZero.map((f) => f.title).toList());
        LinkZero.addAll(EspitemeZero.map((f) => f.link).toList());
      });
    });
    API.Episteme(1).then((response){
      setState(() {
        Iterable listZero = json.decode(response.body);
        // ignore: non_constant_identifier_names
        List<JsonEpisteme> EspitemeOne = listZero.map((model) => JsonEpisteme.fromJson(model)).toList();
        ImageOne.addAll(EspitemeOne.map((f) => f.image).toList());
        TitleOne.addAll(EspitemeOne.map((f) => f.title).toList());
        LinkOne.addAll(EspitemeOne.map((f) => f.link).toList());
      });
    });
    API.Episteme(2).then((response){
      setState(() {
        Iterable listZero = json.decode(response.body);
        // ignore: non_constant_identifier_names
        List<JsonEpisteme> EspitemeTwo = listZero.map((model) => JsonEpisteme.fromJson(model)).toList();
        ImageTwo.addAll(EspitemeTwo.map((f) => f.image).toList());
        TitleTwo.addAll(EspitemeTwo.map((f) => f.title).toList());
        LinkTwo.addAll(EspitemeTwo.map((f) => f.link).toList());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fundo.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child:ListView(
                padding: EdgeInsets.only(top: 20,),
                children: <Widget>[
                  Image(image: AssetImage("assets/images/Logo.png"), height: 120,),
//                  Container(
//                    margin: EdgeInsets.only(left: 50, right: 50),
//                    height: 200,
//                    child: Card(
//
//                      color: Colors.blue,
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: [
//                          Image(image: NetworkImage('https://files.passeidireto.com/Thumbnail/7ffed3bb-4c54-45fc-80f0-025701cb302c/210/1.jpg',),width: 80,),
//                          Text("oiiiioioi")
//                        ],
//                      ),
//                    ),
//                  ),
                  Container(
                    height: 286,
                    width: double.infinity,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10.0,),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          semanticContainer: true,
                          color: Colors.blue[900],
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5),
                                child: Image(
                                  image: NetworkImage('https://files.passeidireto.com/Thumbnail/7ffed3bb-4c54-45fc-80f0-025701cb302c/210/1.jpg',),
//                                  width: 140,
                                  fit: BoxFit.fill,
                                  height: 240,
                                ),
                              ),
                              Text(
                                "ENEM",
                                style: TextStyle(
                                  color: Colors.white
                                ),
                              ),
                              Text(
                                "2019",
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              )
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.only(right: 15),
                        );
                      },
                    ),
                  ),

                  Center(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 140.0,
                          height: 140.0,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                          ),
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text("3", style: TextStyle(color: Colors.white, fontSize: 80),),
                        ),
                        Container(
                          width: 160,
                          height: 40,
                          child: Card(
                            color: Colors.blue,
                            child: Center(
                              child: Text("NÍVEL", style: TextStyle(color: Colors.white, fontSize: 24),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

//                  ContentScrollNews(typpe: 'opadiopdfs', newsTitle: TitleZero, images: ImageZero, link: LinkZero,),
//                  ContentScrollNews(typpe: 'Repertório', newsTitle: TitleOne, images: ImageOne, link: LinkOne,),
//                  ContentScrollNews(typpe: 'Política', newsTitle: TitleTwo, images: ImageTwo, link: LinkTwo,),



                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Continue sua jornada", style: TextStyle(fontSize: 18, color: Colors.black),),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, color: Colors.black,),
                          onPressed: (){

                          },)
                      ],
                    ),
                  ),
                  ContentScrollExercise(newsTitle: Names,),
                ]
            )
        )
    );
  }
}
