
//widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Comments extends StatelessWidget {
  final String Title;
  final String Name;
  final String Matter;

  Comments({
    this.Title,
    this.Name,
    this.Matter
  });

  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(Name, style: TextStyle(fontWeight: FontWeight.bold),),
                Text(Matter, style: TextStyle(color: Colors.black.withOpacity(0.5)),),
                Row(
                  children: <Widget>[
                    Text('256',style: TextStyle(color: Colors.black.withOpacity(0.8)),),
                    IconButton(
                      icon: Icon(Icons.message),
                      color: Colors.black.withOpacity(0.5),
                      onPressed: (){
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            width: 170,
            height: 120,
            child: ListView(
              children: <Widget>[
                Text(Title)
              ],
            ),
          ),
          IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(Icons.reply),
            color: Colors.black.withOpacity(0.8),
            onPressed: (){

            },
          ),
        ],
      ),
    );
  }
}