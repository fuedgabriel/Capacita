import 'dart:convert';

//import 'package:Imperium/screens/Widget/hex_color.dart';
import 'package:Capacita/screen/Widget/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:Capacita/request/RequestMatter.dart';
import 'package:Capacita/request/Json/Matter/JsonClass.dart';

import 'package:url_launcher/url_launcher.dart';

class Class extends StatefulWidget {
  final String id;
  final String title;
  Class(this.id, this.title);
  @override
  _ClassState createState() => _ClassState();
}


class _ClassState extends State<Class> {
  List<JsonClass> videos;

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  buildContainer() {
    return Container(
        child: FutureBuilder(
            future: APIMatter.ClassSearch(widget.id).then((response){
              setState(() {
                Iterable list = json.decode(response.body);
                videos = list.map((model) => JsonClass.fromJson(model)).toList();
              });
              return videos;
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {

                return ListView.builder(
                    itemCount: videos.length,
                    padding: EdgeInsets.only(top: 20),
                    itemBuilder: (context, index){
                      IconData videoWidget = Icons.file_download;
                      if(videos[index].doc == null || videos[index].doc == ""){

                         videoWidget = Icons.videocam;
                      }
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white60),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            leading: IconButton(
                              icon: Icon(videoWidget, color: Colors.black54,),
                              onPressed: (){
                                if(videoWidget == Icons.videocam){
                                  _launchURL(videos[index].link);
                                }else{
                                  _launchURL(videos[index].doc);
                                }

                              },
                            ),
                            title: Text(
                              videos[index].title,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.play_circle_outline, color: Colors.brown, size: 40.0),
                              onPressed: (){
                                if(videoWidget == Icons.videocam){
                                  _launchURL(videos[index].link);
                                }else{
                                  _launchURL(videos[index].doc);
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    }
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

//  Widget CheckWidget(id, Title, index) {
//    if(Title == "" || Title ==null){
//      return Container();
//    }
//    else{
//      return CheckboxListTile(
//        title: Text(Title, ),
//        value: checkedValue[index],
//        onChanged: (newValue) {
//          setState(() {
//            checkedValue[index] = newValue;
//            if(newValue == false){
//              matter.remove(id);
//            }else{
//              matter.add(id);
//            }
//
//
//          });
//        },
//        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
//      );
//    }
//  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.25),
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(242, 162, 2, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(40)),
        ),
        title: Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.15), child: Center(child: Text(widget.title,) ),),
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
