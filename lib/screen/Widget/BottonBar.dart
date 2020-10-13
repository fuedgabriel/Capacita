import 'package:flutter/material.dart';
//page
import '../Config/Config.dart';
import '../Matter/Matter.dart';
import '../Home/Home.dart';
//import '../News/News.dart';
//import '../Simulator/Simulator.dart';

class BottonBar extends StatefulWidget {
  @override
  _BottonBar createState() => _BottonBar();
}

class _BottonBar extends State<BottonBar> {
  int _currentIndex = 0;
  PageController _c;
  @override
  void initState(){
    _c = PageController(
      initialPage: _currentIndex,
    );
    super.initState();
  }
  final tabs = [
    Matter(),
//    News(),
    Home(),
//    Simulator(),
    Config()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.white,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Colors.yellow))), // sets the inactive color of the `BottomNavigationBar`
        child:BottomNavigationBar(
          elevation: 10,
          type: BottomNavigationBarType.shifting,
          currentIndex: _currentIndex,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.orangeAccent,
          backgroundColor: Colors.grey,
          unselectedLabelStyle: TextStyle(
              color: Colors.grey
          ),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('Matérias'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Início'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chrome_reader_mode),
              title: Text('Simulados'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Configurações'),
            ),
          ],

          onTap: (index){
            setState(() {
              this._c.jumpToPage(index);
            });
          },
        ),),
      body: PageView(
        controller: _c,

        onPageChanged: (newPage){
          setState((){
            this._currentIndex=newPage;
          });
        },
        children: <Widget>[
          Matter(),
//          News(),
          Home(),
//          Simulator(),
          Config()
        ],
      ),
    );
  }
}
