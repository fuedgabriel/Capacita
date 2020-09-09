import 'package:http/http.dart' as http;
const String ip = 'http://animeseempresa.servehttp.com:7844/api';

class APIProof {
  // ignore: non_constant_identifier_names
  static Future ProofAll() async{
    return await http.get(ip+'/Proof/all');
  }
  // ignore: non_constant_identifier_names
  static Future ClassSearch(id) async{
    return await http.get(ip+'/Class/search/matter/'+id.toString());
  }
  // ignore: non_constant_identifier_names
  static Future ProofSearch(id) async{
    return await http.get(ip+'/ProofList/search/'+id.toString());
  }
  // ignore: non_constant_identifier_names
  static Future YearList(id) async{
    return await http.get(ip+'/CourseProof/search/'+id.toString());
  }

}