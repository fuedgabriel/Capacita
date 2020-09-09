import 'dart:convert';
import 'Account.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../request/RequestLogin.dart';
// ignore: must_be_immutable

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool showPassword = true;
  String showText = "Amostrar senha";
  Color colorLogin = Colors.transparent;
  String textLogin = "";


  // ignore: non_constant_identifier_names
  _PasswordShow(){
    if(showPassword == true){
      setState(() {
        showText = "Ocultar senha";
        showPassword = false;
      });
    }else{
      setState(() {
        showText = "Amostrar senha";
        showPassword = true;
      });
    }
  }


  // ignore: non_constant_identifier_names
  _saveLogin(Email, Name, Matricula, ID, Courses ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Email', Email.toString());
    prefs.setString('Name', Name.toString());
    prefs.setString('Matricula', Matricula.toString());
    prefs.setStringList('Courses', Courses);
    prefs.setString('_id', ID.toString());
  }

  TextEditingController _textFieldControllerEmail = TextEditingController();
  TextEditingController _textFieldControllerSenha = TextEditingController();

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('_id');
    if (userId != null) {
      print(userId);
      print('login efetuado');
      Navigator.pushReplacementNamed(context, '/BottonBar');
    }return;
  }

  void initState() {
    super.initState();
    autoLogIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, 30),
              child: Image(height: 250,image: AssetImage('assets/images/Logo.png')),
            ),
            SizedBox(height: 50,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  children: <Widget>[
                    Theme(
                      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                      child: TextField(
                        cursorColor: Colors.white,
                        autofocus: true,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        controller: _textFieldControllerEmail,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Email: ",
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
                  ],
                )
            ),
            SizedBox(height: 10,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                    Theme(
                      data: Theme.of(context).copyWith(splashColor: Colors.transparent),
                      child: TextField(
                        cursorColor: Colors.yellowAccent,
                        autofocus: false,
                        obscureText: showPassword,
                        keyboardType: TextInputType.text,
                        controller: _textFieldControllerSenha,
                        decoration: InputDecoration(
                          hintText: "Senha: ",
                          fillColor: Colors.white,
                          filled: true,
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
                    FlatButton(
                      child: Text(showText, style: TextStyle(color: Colors.brown),),
                      onPressed: (){
                        _PasswordShow();
                      },
                    ),
                  ],
                )
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 35,
              child: Text(textLogin,
                style: TextStyle(
                    fontSize: 16,
                    color: colorLogin
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20,),
              height: 45,
              child: FlatButton(
                color: Colors.orange,
                shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, '/BottonBar');
                  APILOGIN.postLogin(_textFieldControllerEmail.text, _textFieldControllerSenha.text).then((response) async {
                    var login = json.decode(response.body);
                    List<String> lista = [];

                    if((login) != null){
                      setState(() {
                        textLogin = "Login efetuado com sucesso";
                        colorLogin = Colors.green;
                      });

                      lista.add((login['Courser'][0]['1']));
                      lista.add((login['Courser'][0]['2']));
                      lista.add((login['Courser'][0]['3']));
                      lista.add((login['Courser'][0]['4']));
                      lista.add((login['Courser'][0]['5']));
                      lista.add((login['Courser'][0]['6']));
                      lista.remove(null); lista.remove(null); lista.remove(null); lista.remove(null);
                      _saveLogin(login['Email'], login['Name'], login['Matricula'], login['_id'], lista);

                      Navigator.pushReplacementNamed(context, '/BottonBar');
                    }
                    else{
                      setState(() {
                        colorLogin = Colors.red;
                        textLogin = "Login inválido";
                      });
                    }
                  });
                },
                child: Text('Começar a estudar', style: TextStyle(color: Colors.white, fontSize: 18),),
              ),
            ),
            SizedBox(height: 20,),

            Container(
              padding: EdgeInsets.only(left: 20, right: 20,),
              height: 45,
              child: FlatButton(
                color: Colors.green,
                shape: StadiumBorder(side: BorderSide(color: Colors.white,)),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Account()));
                },
                child: Text('Criar conta', style: TextStyle(color: Colors.white, fontSize: 18),),
              ),
            ),
            SizedBox(height: 50,),
          ],
        )
    );
  }
}


//const String _shapeSVG_7f7ac021a2b542709744853d0e704d68 =
//    '<svg viewBox="63.9 124.5 192.1 176.1" ><g transform="translate(1283.13, 529.32)"><path transform="translate(-220.16, -2.12)" d="M -998.9723510742188 -227.1583251953125 L -898.0308837890625 -402.586669921875 C -897.9219970703125 -402.8044128417969 -897.6171875 -402.8044128417969 -897.4865112304688 -402.586669921875 C -890.1488647460938 -389.8492431640625 -882.8765869140625 -377.2206726074219 -875.5389404296875 -364.4396667480469 C -875.4300537109375 -364.2437133789063 -875.5607299804688 -364.0042114257813 -875.7784423828125 -363.982421875 C -880.5250244140625 -363.4163208007813 -884.2918701171875 -361.3478393554688 -887.0352783203125 -357.5375061035156 C -888.8860473632813 -354.9682312011719 -889.822265625 -352.0723876953125 -889.8440551757813 -348.8934631347656 C -889.8876342773438 -342.2525634765625 -885.8594970703125 -336.4390869140625 -879.6976318359375 -334.2399597167969 C -873.7535400390625 -332.1061706542969 -866.590087890625 -333.7174072265625 -861.9523315429688 -339.9663696289063 C -861.8216552734375 -340.1405639648438 -861.5386352539063 -340.1405639648438 -861.4297485351563 -339.944580078125 C -854.0921020507813 -327.1853637695313 -846.7980346679688 -314.4914855957031 -839.4168701171875 -301.688720703125 C -839.3079833984375 -301.4709777832031 -839.4385986328125 -301.2314758300781 -839.6781005859375 -301.2314758300781 L -896.5938110351563 -301.2314758300781 C -896.8333129882813 -301.2314758300781 -896.9857177734375 -301.4927673339844 -896.8768310546875 -301.688720703125 C -896.6373291015625 -302.1459655761719 -896.3978271484375 -302.5596618652344 -896.1583251953125 -302.9733581542969 C -892.9794311523438 -308.5037841796875 -889.822265625 -314.0559997558594 -886.6433715820313 -319.5864562988281 C -886.3385009765625 -320.1090087890625 -886.164306640625 -320.5444946289063 -886.5126953125 -321.1759033203125 C -889.822265625 -327.0547485351563 -893.1100463867188 -332.9335632324219 -896.3978271484375 -338.8123779296875 C -896.4196166992188 -338.8559265136719 -896.44140625 -338.8994750976563 -896.4849243164063 -338.9430236816406 C -896.6156005859375 -339.1172180175781 -896.8768310546875 -339.1172180175781 -897.0075073242188 -338.9430236816406 C -897.159912109375 -338.7252807617188 -897.29052734375 -338.5293273925781 -897.3994140625 -338.3115844726563 C -911.5086059570313 -313.0979919433594 -925.6613159179688 -287.9061584472656 -939.792236328125 -262.6925354003906 C -946.3677978515625 -250.9566650390625 -952.943359375 -239.2425842285156 -959.5189208984375 -227.5067138671875 C -959.802001953125 -227.0276947021484 -960.019775390625 -226.6575469970703 -960.7164916992188 -226.6575469970703 C -973.3886108398438 -226.6793212890625 -986.0389404296875 -226.6793212890625 -998.7110595703125 -226.6793212890625 L -998.7110595703125 -226.6793212890625 C -998.9506225585938 -226.7010955810547 -999.10302734375 -226.9623718261719 -998.9723510742188 -227.1583251953125 Z" fill="#4e2769" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /><path transform="translate(-511.24, -418.16)" d="M -516.1359252929688 171.3186340332031 L -626.6141967773438 171.3186340332031 C -626.8536987304688 171.3186340332031 -626.9843139648438 171.0791320800781 -626.897216796875 170.8613891601563 C -626.8101196289063 170.6872100830078 -626.7230224609375 170.5130310058594 -626.6359252929688 170.3606109619141 C -618.7974853515625 156.8828735351563 -610.9591064453125 143.4269104003906 -603.1424560546875 129.9491577148438 C -602.7940673828125 129.3395080566406 -602.4238891601563 129.1000061035156 -601.7053833007813 129.1000061035156 C -581.3908081054688 129.1217803955078 -561.076171875 129.1217803955078 -540.7615966796875 129.1000061035156 C -540.1083984375 129.1000061035156 -539.73828125 129.2959594726563 -539.389892578125 129.8620758056641 C -531.6385498046875 143.3833618164063 -523.865478515625 156.8828735351563 -516.0923461914063 170.3823852539063 C -516.0052490234375 170.5130310058594 -515.93994140625 170.6654357910156 -515.8528442382813 170.8396301269531 C -515.7657470703125 171.0791320800781 -515.9181518554688 171.3186340332031 -516.1359252929688 171.3186340332031 Z" fill="#4e2769" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></g></svg>';


