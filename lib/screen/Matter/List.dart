import 'dart:convert';
//import 'package:Imperium/screens/Widget/hex_color.dart';
import 'package:flutter/material.dart';
//import 'Class/BottonBar.dart';
import '../../request/RequestMatter.dart';
import '../../request/Json/Matter/JsonMatterSearch.dart';


class ListMatter extends StatefulWidget {
  final String id;
  ListMatter(this.id);
  @override
  _ListMatterState createState() => _ListMatterState();
}

class _ListMatterState extends State<ListMatter> {

  List<JsonMatterSearch> search;


  buildContainer() {
    return Container(
        child: FutureBuilder(
            future: APIMatter.MatterSearch(widget.id).then((response){
              setState(() {
                Iterable list = json.decode(response.body);
                search = list.map((model) => JsonMatterSearch.fromJson(model)).toList();
              });
              return search;
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing:0,),
                    scrollDirection: Axis.vertical,
                    itemCount: search.length,
                    padding: EdgeInsets.only(left: 5, top: 0,right: 0,bottom: 0),
                    itemBuilder: (context, index) {
                      return Center(
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Card(
                                color: Colors.amber[800],
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: Container(
                                  height: 160,
                                  decoration: BoxDecoration(
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
                                            Colors.orange[600],
                                            Colors.orange[600],
                                            Colors.orange[500],
                                            Colors.blue[800]
                                          ])),
                                  child: GestureDetector(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image(
                                          image: NetworkImage(search[index].image),
                                          fit: BoxFit.fitHeight,
                                          height: 120,
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
                                    onTap: (){
//                                      Navigator.push(context, MaterialPageRoute(builder: (context) => BottonBar(search[index].sId, search[index].title)));
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
      backgroundColor: Colors.white.withOpacity(0.79),
      appBar: AppBar(
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(40)),),
        title: Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.15), child: Center(child: Text('Matérias',) ),
      ),),
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
