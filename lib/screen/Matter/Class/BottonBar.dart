import 'package:flutter/material.dart';
//pages
import 'Class.dart';
import 'Exercices.dart';

class BottonBar extends StatefulWidget {
  final String id;
  final String title;
  BottonBar(this.id, this.title);
  @override
  _BottonBar createState() => _BottonBar(id, title);
}

class _BottonBar extends State<BottonBar> {
  int _currentIndex = 0;

  var tabs = [

  ];

  _BottonBar(id, title){
    tabs = [
      Class(id, title),
      Exercices(id, title)
    ];


  }

  PageController _c;
  @override
  void initState(){
    _c =  new PageController(
      initialPage: _currentIndex,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.amber[800],
        backgroundColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
            color: Colors.grey
        ),

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Aulas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.font_download),
            title: Text('Exercícios'),
          ),
        ],

        onTap: (index){
          setState(() {
            this._c.jumpToPage(index);
          });
        },
      ),
      body: PageView(
        controller: _c,
        onPageChanged: (newPage){
          setState((){
            this._currentIndex=newPage;
          });
        },
        children: <Widget>[
          Class(widget.id, widget.title),
          Exercices(widget.id, widget.title)
        ],
      ),
    );
  }
}
