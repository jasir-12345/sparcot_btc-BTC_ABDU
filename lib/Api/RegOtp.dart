import 'dart:convert';

import 'package:http/http.dart' as http;

import '../utils/constants.dart';

Future regOtp(String name,String pass,String otp,String detail,String mob) async {
  String url = baseUrl + strOpenPort + strRegisterUser;
  print("nameeeeeeeeeeeeeeeeeeeeeee");
  print(name);
  print(pass);
  print(otp);
  print(detail);

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json", "strAppInfo": strAppInfo},
    body: jsonEncode(<String, String>{
      //   'strStep': "VERIFY",
      "strType": "CUSTOMER",
      "strName": name,
      "strPassword":pass,
      "strOTP":otp,
      "strSessionId":detail,
      "strMobileNo": mob,
      "arrAddress": "",
    }),
  );
  var convertDataToJson = json.decode(response.body);
  return convertDataToJson;
}
