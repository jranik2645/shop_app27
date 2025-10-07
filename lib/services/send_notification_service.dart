import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'get_services_key.dart';
import 'package:http/http.dart' as http;

class SendNotificationService {
  static Future<void> sendNotificationUsingApi({
    required String? token,
    required String? title,
    required String? body,
    required Map<String, dynamic>? data,
  }) async {
    String serverKey = await GetServerKey().getServerKeyToken();

    String url = "";
    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };

    Map<String, dynamic> message = {
      'message': {
        'token': token,
        'notification': {"body": body, 'title': title},
        'data': data,
      },
    };
      ///http api
    final http.Response response=await http.post(
      Uri.parse(url),
      headers:headers,
      body:jsonEncode(message),
    );

     if(response.statusCode==200){
        if (kDebugMode) {
          print("Notification Send Successfully!");
        }
     }else{
       if (kDebugMode) {
         print("Notification not send");
       }
     }
  }
}
