
//widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//// ignore: must_be_immutable
//class ContentScrollMatter extends StatelessWidget {
//  final List matter;
//  final List images;
//
//  ContentScrollMatter({
//    this.matter,
//    this.images
//  });
//
//
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Padding(
//          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Text(
//                'Matérias ',
//                style: TextStyle(
//                    fontSize: 20.0,
//                    color: Colors.white
//                ),
//              ),
//              GestureDetector(
//                onTap: () {
//                },
//                child: Icon(
//                  Icons.arrow_forward,
//                  size: 30.0,
//                  color: Colors.black,
//                ),
//              ),
//            ],
//          ),
//        ),
//        Container(
//          height: 160,
//          width: double.infinity,
//          child: ListView.builder(
//            padding: EdgeInsets.symmetric(horizontal: 0.0),
//            scrollDirection: Axis.horizontal,
//            itemCount: images.length,
//            itemBuilder: (BuildContext context, int index) {
//              return Card(
//                semanticContainer: true,
//                clipBehavior: Clip.antiAliasWithSaveLayer,
//                child: Row(
//                  children: <Widget>[Image.asset(
//                    'assets/'+images[index], fit: BoxFit.cover,
//                    height: 160,
//                    width: 160,
//                  ),
//                    SizedBox(width: 2,),
//                    Text(matter[index]),
//                    SizedBox(width: 2,),
//                  ],
//                ),
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(10.0),
//                ),
//                elevation: 5,
//                margin: EdgeInsets.all(10),
//              );
//            },
//          ),
//        ),
//      ],
//    );
//  }
//}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
class ContentScrollExercise extends StatelessWidget {
  final List newsTitle;

  ContentScrollExercise({
    this.newsTitle,
  });


  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      height: 160,
      width: double.infinity,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,
        itemCount: newsTitle.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(0),
            width: 240,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: GestureDetector(
                child: ListView(
                  padding: EdgeInsets.all(10),
                  children: [
                    Text(newsTitle[index], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    Image(
                      height: 70,
                      fit: BoxFit.cover,
                      image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSF4NmiJSlo8SyQI6JS_cEzgc_aHobzJf7Wxw&usqp=CAU',),
                    )

                  ],
                ),
                onTap: (){
                },
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
          );
        },
      ),
    );
  }
}
class ContentScrollNews extends StatelessWidget {
  final String typpe;
  final List newsTitle;
  final List images;
  final List link;

  ContentScrollNews({
    this.typpe,
    this.newsTitle,
    this.images,
    this.link
  });


  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                typpe+' ',
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 160,
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            scrollDirection: Axis.horizontal,
            itemCount: newsTitle.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Image.network(
                        images[index],
                        fit: BoxFit.cover,
                        height: 160,
                        width: 160,
                      ),
                      onTap: (){
                        _launchURL(link[index]);
                      },
                    ),
                    SizedBox(width: 2,),

                    Container(
                      height: 120,
                      width: 150,
                      child: Text(
                        newsTitle[index],
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              );
            },
          ),
        ),
      ],
    );
  }
}