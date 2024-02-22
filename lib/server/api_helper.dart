import 'dart:convert';
import 'dart:io';

import 'package:company/model/employee_data_request_model.dart';
import 'package:company/model/employee_data_response_model.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/adapters/io_adapter.dart';
import 'package:flutter/foundation.dart';

class APIHelper {
  final dio = Dio();
  final uri = "https://examination.24x7retail.com/api/v1.0/Employees";
  final token = '?D(G+KbPeSgVkYp3s6v9y\$B&E)H@McQf';

  APIHelper() {
    dio.options = options;
    dio.options.headers['apiToken'] = token;
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  BaseOptions options = BaseOptions(
    baseUrl: "https://examination.24x7retail.com/api/v1.0/Employees",
    contentType: 'application/json',
  );

  Future<dynamic> post(EmployeeDataRequestModel employeeDataRequestModel) async {
    try {
      final response = await dio.post(
        uri,
        data: employeeDataRequestModel.toJson(),
      );
      return response;
    } on DioException catch (error) {
      debugPrint(error.message);
    }
  }

  Future<dynamic> put(EmployeeDataRequestModel employeeDataRequestModel, String id) async {
    try {
      final response = await dio.put(
        '$uri/$id',
        data: employeeDataRequestModel.toJson(),
      );
      return response;
    } on DioException catch (error) {
      debugPrint(error.message);
    }
  }

  Future<List<EmployeeDataResponseModel>> getAllData() async {
    try {
      final response = await dio.get(
        uri,
      );

      print(response);

      final data = employeeDataResponseModelFromJson(jsonEncode(response.data));

      print(data);
      return data;
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    }
  }

  Future<EmployeeDataResponseModel> getData(String id) async {
    try {
      final response = await dio.get(
        "$uri/$id",
      );

      print(response);

      final data = EmployeeDataResponseModel.fromJson(response.data);

      print(data);
      return data;
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    }
  }

  Future<dynamic> delete(String id) async {
    try {
      final response = await dio.delete(
        "$uri/$id",
      );

      print(response);

      final data = EmployeeDataResponseModel.fromJson(response.data);

      print(data);
      return response;
    } on DioException catch (error) {
      debugPrint(error.message);
      rethrow;
    }
  }
}
