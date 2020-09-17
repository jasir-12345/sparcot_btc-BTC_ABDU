import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';

Future sendOtp(String name,String mob) async {
  String url = baseUrl + strOpenPort + strForgetPass;

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json", "strAppInfo": strAppInfo},
    body: jsonEncode(<String, String>{
      'strStep': "REGISTER",
      "strType": "CUSTOMER",
      "strName": name,
      "strMobileNo": mob
    }),
  );
  var convertDataToJson = json.decode(response.body);
  return convertDataToJson;
}
