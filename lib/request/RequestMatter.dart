import 'dart:convert';

import 'package:http/http.dart' as http;
const String ip = 'http://animeseempresa.servehttp.com:7844/api';

class APIMatter {
  // ignore: non_constant_identifier_names
  static Future MatterSearch(id) async{
    return await http.get(ip+'/Matter/search/matter/'+id.toString());
  }
  // ignore: non_constant_identifier_names
  static Future ClassSearch(id) async{
    return await http.get(ip+'/Class/search/matter/'+id.toString());
  }
  // ignore: non_constant_identifier_names
  static Future QuestionSearch(id) async{
    return await http.get(ip+'/Question/search/matter/'+id.toString());
  }
  // ignore: non_constant_identifier_names
  static Future ExercisesSearch(id) async{
    return await http.get(ip+'/Exercises/search/question/'+id.toString());
  }
  // ignore: non_constant_identifier_names
  static Future SelectorSearch(IDuser, IDquestion ) async{
    try{
      Map data = {
        'User': '$IDuser',
        'Question': '$IDquestion'
      };
      var body = json.encode(data);
      return await http.post(ip+'/Colector/search', headers: {"Content-Type": "application/json"}, body: body);
    }
    catch (error) {
      return false;
    }
  }
  // ignore: non_constant_identifier_names
  static Future SelectorInsert(IDuser, IDquestion, Percent ) async{
    try{
      Map data = {
        'User': '$IDuser',
        'Question': '$IDquestion',
        'Percent' : Percent
      };
      var body = json.encode(data);
      return await http.post(ip+'/Colector', headers: {"Content-Type": "application/json"}, body: body);
    }
    catch (error) {
      return false;
    }
  }
  // ignore: non_constant_identifier_names
  static Future SelectorUpdate(IDquestion, Percent) async{
    try{
      Map data = {
        'Percent': Percent
      };
      var body = json.encode(data);
      return await http.put(ip+'/Colector/update/'+IDquestion.toString(), headers: {"Content-Type": "application/json"}, body: body);
    }
    catch (error) {
      return false;
    }
  }

}