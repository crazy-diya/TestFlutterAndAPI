import 'dart:convert';

import 'package:company/model/employee_data_request_model.dart';
import 'package:company/model/employee_data_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class APIHelper {
  final dio = Dio();

  APIHelper() {
    dio.options = options;
  }

  String uri = "http://192.168.8.100:5002/api/v1/employee/";

  BaseOptions options = BaseOptions(
    baseUrl: "http://192.168.8.100:5002/api/v1/employee/",
    contentType: 'application/json',
  );

  Future<dynamic> post(
      EmployeeDataRequestModel employeeDataRequestModel) async {
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

  Future<dynamic> put(
      EmployeeDataRequestModel employeeDataRequestModel, String id) async {
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
