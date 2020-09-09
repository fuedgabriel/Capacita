//widget
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CheckOp extends StatelessWidget {
  List<String> id;


  CheckOp({
    this.id
  });



  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 0.0),
      scrollDirection: Axis.vertical,
      itemCount: id.length,
      itemBuilder: (BuildContext context, int index) {
        return ;
      },
    );
  }
}