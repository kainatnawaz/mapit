import 'dart:developer';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;


class ApiRequest {

  // Get function for map
  Future getMap({
    String? url,
    Function(String)? onSuccess,
    Function(String)? onError,
  }) async {
    try {
      debugPrint("this is get Url: $url");

      var response = await http
          .get(
        Uri.parse(url!),
      )
          .timeout(const Duration(seconds: 60), onTimeout: () {
        throw Exception("Request Time Out");
      });
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        onSuccess!(response.body);
      } else if (response.statusCode == 204) {
        onError!(response.body);
      } else if (response.statusCode == 404) {
        onError!(response.body);
      } else {
        log("i am in error  ${response.body}");
        onError!(response.body);
      }
    } catch (e) {
      log("i am in error catch ${e.toString()}");
      onError!(e.toString());
    }
  }
}
