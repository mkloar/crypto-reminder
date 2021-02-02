import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto_reminder/networking/api_exceptions.dart';
import 'dart:async';

class ApiBaseHelper {
  String _baseURL;

  ApiBaseHelper(String baseUrl) {
    this._baseURL = baseUrl;
  }

  Future<dynamic> get(String endPoint) async {
    var responseJson;
    try {
      final response = await http.get(this._baseURL + endPoint);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occurred while communication with server with statusCode : ${response.statusCode}');
  }
}
