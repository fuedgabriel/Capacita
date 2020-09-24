

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Config extends StatefulWidget {
  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  String user = '';
  String matricula = '';
  String email = '';
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  // ignore: non_constant_identifier_names
  _ConfigState(){
    name();
  }
  name() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString('Name');
      email = prefs.getString('Email');
      matricula = prefs.getString('Matricula');
      print(user);
    });
  }
  @override
  Widget build(BuildContext context) {

//    Container(
//        decoration: BoxDecoration(
//          image: DecorationImage(
//            image: AssetImage("assets/images/fundo.jpg"),
//            fit: BoxFit.cover,
//          ),
//        ),
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fundo.jpg"),
              fit: BoxFit.cover
            )
          ),
          child: ListView(
            padding: EdgeInsets.only(top: 10),
            children: <Widget>[
              Image(image: AssetImage("assets/images/Logo.png"), height: 200,),
//              ListTile(
//                leading: Icon(Icons.phone, color: Colors.white, size: 32,),
//                title: Text('Telefone', style: TextStyle(color: Colors.white),),
//                subtitle: Text('(21) 3593-7503', style: TextStyle(color: Colors.yellow),),
//                trailing: Icon(Icons.keyboard_arrow_right),
//                onTap: () {
//                  _launchURL('tel:0213593-7506');
//                },
//              ),
//
//              ListTile(
//                leading: Icon(Icons.phone, color: Colors.white, size: 32,),
//                title: Text('Telefone', style: TextStyle(color: Colors.white),),
//                subtitle: Text('(21) 3593-7506', style: TextStyle(color: Colors.yellow),),
//                trailing: Icon(Icons.keyboard_arrow_right),
//                onTap: () {
//                  _launchURL('tel:0213593-7506');
//                },
//              ),
              ListTile(
                leading: Container(child: Image(image: NetworkImage('https://www.iconfinder.com/data/icons/social-media-chamfered-corner/154/telegram-512.png'), ), height: 32,),
                title: Text('Grupo de estudos', style: TextStyle(color: Colors.blue),),
//                subtitle: Text('(21) 9 9900-5045', style: TextStyle(color: Colors.yellow),),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  _launchURL('https://t.me/capacita_estudos');
                },
              ),
//              ListTile(
//                leading: Container(child: Image(image: NetworkImage('https://cdn.iconscout.com/icon/free/png-256/facebook-logo-2019-1597680-1350125.png'), ), height: 32,),
//                title: Text('Facebook', style: TextStyle(color: Colors.white),),
//                subtitle: Text('Imperium Concursos @imperiumconcursos', style: TextStyle(color: Colors.yellow),),
//                trailing: Icon(Icons.keyboard_arrow_right),
//                onTap: () {
//                  _launchURL('https://www.facebook.com/imperiumconcursos/');
//                },
//              ),
//              ListTile(
//                leading: Icon(Icons.add_location, color: Colors.white, size: 32,),
//                title: Text('Endereço', style: TextStyle(color: Colors.white),),
//                subtitle: Text('Av. Cesário de Melo nº 2541, Campo Grande - RJ', style: TextStyle(color: Colors.yellow),),
//                trailing: Icon(Icons.keyboard_arrow_right),
//                onTap: () {
//                  _launchURL('https://www.google.com/maps?q=Av.%20Ces%C3%A1rio%20de%20Melo%20n%C2%BA%202541,%20Campo%20Grande%20-%20RJ');
//                },
//              ),
//              ListTile(
//                leading: Icon(Icons.email, color: Colors.white, size: 32,),
//                title: Text('E-MAIL', style: TextStyle(color: Colors.white),),
//                subtitle: Text('atendimento@imperiumconcursos.com.br', style: TextStyle(color: Colors.yellow),),
//                trailing: Icon(Icons.keyboard_arrow_right),
//                onTap: () {
//                  _launchURL('mailto:atendimento@imperiumconcursos.com.br');
//                },
//              ),
              ListTile(
                leading: Icon(Icons.email, color: Colors.white, size: 32,),
                title: Text('Envie uma sugestão, crítica e erros relacionados ao aplicativo', style: TextStyle(color: Colors.blue, ) ,),
                subtitle: Text('fuedgabriel@hotmail.com', style: TextStyle(color: Colors.orange),),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  _launchURL('mailto:fuedgabriel@hotmail.com');
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 80,
                  width: MediaQuery.of(context).size.width*0.80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: ListView(
                    padding: EdgeInsets.all(10),
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('Usuário: '+user.toString(), style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black.withOpacity(0.7)),),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('E-MAIL: '+email.toString(), style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black.withOpacity(0.7)),),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('Matrícula: '+matricula.toString(), style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.black.withOpacity(0.7)),),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: FlatButton(
                  onPressed: () async {
                    showGeneralDialog(
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionBuilder: (context, a1, a2, widget) {
                          return Transform.scale(
                            scale: a1.value,
                            child: Opacity(
                              opacity: a1.value,
                              child: AlertDialog(
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Não',),
                                    color: Colors.green,
                                  ),
                                  FlatButton(
                                    child: Text("Sim"),
                                    color: Colors.red,
                                    onPressed: () async{
                                      final prefs = await SharedPreferences.getInstance();
                                      prefs.clear();
                                      Navigator.of(context).pushNamedAndRemoveUntil('/Login', (Route<dynamic> route) => false);
                                    },
                                  )
                                ],
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                title: Text('Você realmente deseja sair?',
                                  style: TextStyle(
                                    fontSize: 15.6,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 500),
                        barrierDismissible: true,
                        barrierLabel: '',
                        context: context,
                        pageBuilder: (context, animation1, animation2) {var a; return a; });
                  },
                  child: Text("Sair da conta",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
