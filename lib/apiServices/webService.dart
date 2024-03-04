
import 'dart:isolate';
import 'package:http/http.dart' as http;

import 'baseService.dart';
import 'urls.dart';

class ApiService extends BaseService {
 

  Future getResponse(String url, headers) async {
    dynamic responseJson;
    try {
      // responseJson =
      //     await http.get(Uri.parse(Urls.BASE_URL + url), headers: headers);
      final response = ReceivePort();
      await Isolate.spawn(
          isolate, [Urls.BASE_URL + url, headers, response.sendPort]);
      return await response.first;
      // log("get response" + Urls.BASE_URL + url);
    } catch (e) {
      throw e;
    }
  }

  void isolate(List<dynamic> args) async {
    final url = args[0];
    final headers = args[1];
    final sendPort = args[2];
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      responseJson = response;
      
    } catch (e) {
      throw e;
    }
    sendPort.send(responseJson);
  }

  

  @override
  Future postResponse(String url, body, headers) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(Urls.BASE_URL + url),
          body: body, headers: headers);

      responseJson = response;
    } on Exception {
      throw UnimplementedError();
    }
    return responseJson;
  }

 
}
