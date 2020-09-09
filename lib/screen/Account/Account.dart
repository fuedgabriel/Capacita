import 'dart:async';
import 'dart:convert';

import '../../request/RequestLogin.dart';
import 'package:flutter/material.dart';
import '../../request/Json/Matter/JsonMatterSearch.dart';
class Account extends StatefulWidget {
  @override
  _Account createState() => _Account();
}



class _Account extends State<Account> {


  TextEditingController _textFieldControllerNome = TextEditingController();
  TextEditingController _textFieldControllerMatricula = TextEditingController();
  TextEditingController _textFieldControllerEmail = TextEditingController();
  TextEditingController _textFieldControllerSenha1 = TextEditingController();
  TextEditingController _textFieldControllerSenha2 = TextEditingController();

  String _validarEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Informe o Email";
    } else if(!regExp.hasMatch(value)){
      return "Email inválido";
    }else {
      return null;
    }
  }

  var Course = List<JsonMatterSearch>();
  _Account(){
    APILOGIN.CourserAll().then((response){
      Iterable list = json.decode(response.body);
      setState(() {
        Course = list.map((model) => JsonMatterSearch.fromJson(model)).toList();
      });
    });
  }

  List<String> matter = [];
  List<bool> checkedValue = [false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false,false];

  Widget CheckWidget(id, Title, index) {
    if(Title == "" || Title ==null){
      return Container();
    }
    else{
      return CheckboxListTile(
        title: Text(Title, ),
        value: checkedValue[index],
        onChanged: (newValue) {
          setState(() {
            checkedValue[index] = newValue;
            if(newValue == false){
              matter.remove(id);
            }else{
              matter.add(id);
            }


          });
        },
        controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Criar conta'),
        ),
        body: ListView(children: <Widget>[
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.0),
            child: TextField(
              controller: _textFieldControllerNome,
              decoration: InputDecoration(
                hintText: "Nome",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.0),
            child: TextFormField(
              validator: _validarEmail,
              controller: _textFieldControllerEmail,
              decoration: InputDecoration(
                hintText: "E-mail",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.0),
            child: TextField(
              obscureText: true,
              controller: _textFieldControllerSenha1,
              decoration: InputDecoration(
                hintText: "Senha",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.0),
            child: TextField(
              obscureText: true,
              controller: _textFieldControllerSenha2,
              decoration: InputDecoration(
                hintText: "Senha",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: Course.length,
            itemBuilder: (BuildContext context, int index) {
              return CheckWidget(Course[index].sId, Course[index].title, index);
            },
          ),
          SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.only(left: 40, right: 40,),
            height: 45,
            child: FlatButton(
              color: Colors.green,
              shape: StadiumBorder(side: BorderSide(color: Colors.white)),
              onPressed: (){

                if(_textFieldControllerNome.text.isEmpty || _textFieldControllerEmail.text.isEmpty || _textFieldControllerSenha1.text.isEmpty || _textFieldControllerSenha2.text.isEmpty || _textFieldControllerMatricula.text.isEmpty || matter.length ==0){
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
                                  child: Text("OK"),
                                  onPressed: () {Navigator.of(context).pop(); },
                                )
                              ],
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                              title: Text('Por favor, preencha todos os valores.',
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
                }
                else if(_textFieldControllerSenha1.text != _textFieldControllerSenha2.text){
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
                                  child: Text("OK"),
                                  onPressed: () {Navigator.of(context).pop(); },
                                )
                              ],
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                              title: Text('As senhas não correspondem',
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
                }
                else if(_textFieldControllerSenha1.text.length <=  7){
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
                                  child: Text("OK"),
                                  onPressed: () {Navigator.of(context).pop(); },
                                )
                              ],
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16.0)),
                              title: Text('Senha menor que 8 digitos',
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
                }
                else{
                  APILOGIN.postAccount(_textFieldControllerNome.text, _textFieldControllerEmail.text, _textFieldControllerSenha1.text, _textFieldControllerMatricula.text, matter).then((response){
                    var message = json.decode(response.body);
                    showGeneralDialog(
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionBuilder: (context, a1, a2, widget) {
                          return Transform.scale(
                            scale: a1.value,
                            child: Opacity(
                              opacity: a1.value,
                              child: AlertDialog(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                title: Text(message,
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
//                    Future.delayed(const Duration(milliseconds: 1200), () {
//                      Navigator.of(context).pop();
//                    });
//                    Timer(Duration(milliseconds: 1800), () {
//                      Navigator.of(context).pop();
//                    });
                  });
                }
              },
              child: Text('Efetuar cadastro', style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
          ),
          SizedBox(height: 20,),
        ],
        )
    );
  }
}
