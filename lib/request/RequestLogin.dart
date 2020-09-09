import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';



class ListJson {
  static tag(id1, id2, id3, id4, id5, id6){
    Map toJson() => {
      '1': '$id1',
      '2': '$id2',
      '3': '$id3',
      '4': '$id4',
      '5': '$id5',
      '6': '$id6'
    };
    return toJson();
  }
}

class APILOGIN{

  static Future CourserAll() async{
    return await http.get('http://animeseempresa.servehttp.com:7844/api/Course/all');
  }
  // ignore: non_constant_identifier_names
  static Future postLogin (email, Password) async {
    var key = utf8.encode(Password);
    var hash = sha512.convert(key);
    try{
      Map data = {
        'Email': '$email',
        'Password': '$hash'
      };
      var body = json.encode(data);
      return await http.post('http://animeseempresa.servehttp.com:7844/api/User/id', headers: {"Content-Type": "application/json"}, body: body);
    }
    catch (error) {
      return false;
    }
  }


  static Future<http.Response> postAccount (Name, Email, Password, Matricula, List<String> matter,) async {
    for(int i = matter.length; i <= 5; i++){
      matter.add("");
    }
    var key = utf8.encode(Password);
    var hash = sha512.convert(key);
    try{
      Map data = {
        'Name': '$Name',
        'Email': '$Email',
        'Password': '$hash',
        'Matricula': '$Matricula',
        'Courser': ListJson.tag(matter[0].toString(), matter[1].toString(), matter[2].toString(), matter[3].toString(), matter[4].toString(), matter[5].toString()),
      };
      var body = json.encode(data);
      return await http.post('http://animeseempresa.servehttp.com:7844/api/User', headers: {"Content-Type": "application/json"}, body: body);
    }
    catch (error) {
      print(error);
    }
  }



}