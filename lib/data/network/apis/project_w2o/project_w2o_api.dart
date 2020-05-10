import 'dart:async';

import 'package:dio/dio.dart';
import 'package:project_w2o/models/item_data/item_data_list.dart';

class ProjectW2OAPI {
  final Dio _dioClient;

  // base url
  static const String baseUrl = "http://testemobile.w2o.com.br";
  static const headers = {
    'Content-Type': 'application/json; charset=utf-8',
  };

  // injecting dio instance
  ProjectW2OAPI(this._dioClient);

  Future<ItemDataList> login(String email, String password) async {
    try {
      final response = await _dioClient.get("$baseUrl/login?login=$email&senha=$password");

      return ItemDataList.fromJson(response.data['hash']);
    } on DioError catch (e) {
      print(e.response.statusCode);
      print(e.message);
    }
  }

  Future<ItemDataList> getItems(String hash) async {
    try {
      final response = await Dio().get("$baseUrl/item/lista?hash=$hash");

      return ItemDataList.fromJson(response.data['lista']);
    } on DioError catch (e) {
      print(e.response.statusCode);
      print(e.message);

      throw e;
    }
  }

  Future<dynamic> postItem(int id, Map<String, dynamic> queryParameters) async {
    try {
      final response =
          await _dioClient.post("$baseUrl/item/novo", queryParameters: queryParameters);

      return ItemDataList.fromJson(response.data['lista']);
    } on DioError catch (e) {
      print(e.response.statusCode);
      print(e.message);

      throw e;
    }
  }

  Future<dynamic> putItem(int id, dynamic data) async {
    try {
      final response = await _dioClient.put("$baseUrl/item/form/$id", data: data);

      return ItemDataList.fromJson(response.data['lista']);
    } on DioError catch (e) {
      print(e.response.statusCode);
      print(e.message);

      throw e;
    }
  }

  Future<dynamic> deleteItem(int id, dynamic data) async {
    try {
      final response = await _dioClient.put("$baseUrl/item/delete/$id", data: data);

      return ItemDataList.fromJson(response.data['lista']);
    } on DioError catch (e) {
      print(e.response.statusCode);
      print(e.message);

      throw e;
    }
  }
}
