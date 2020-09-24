
//widget
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';


//pages
import '../../../request/Json/Home/JsonMatter.dart';
import '../List.dart';
// ignore: must_be_immutable
class MyCourses extends StatelessWidget {
  final double percent;
  final List<JsonMatter> matter;

  MyCourses({
    this.matter,
    this.percent
  });


  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 30),
      scrollDirection: Axis.vertical,
      itemCount: matter.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(

          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    matter[index].title,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 270,
              padding: EdgeInsets.only(top: 0, right: 20, left: 20, bottom: 20),
              child: GestureDetector(
                child: CircularPercentIndicator(
                  radius: 210.0,
                  lineWidth: 10.0,
                  percent: 0.3,
                  center: Container(
                      width: 190.0,
                      height: 190.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(matter[index].image)
                          )
                      )
                  ),
                  backgroundColor: Colors.white.withOpacity(0.5),
                  progressColor: Colors.amber,
                ),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListMatter(matter[index].sId)));
                },
              ),
            )
          ],
        );
      },
    );
  }
}