// To parse this JSON data, do
//
//     final employeeDataRequestModel = employeeDataRequestModelFromJson(jsonString);

import 'dart:convert';

EmployeeDataRequestModel employeeDataRequestModelFromJson(String str) => EmployeeDataRequestModel.fromJson(json.decode(str));

String employeeDataRequestModelToJson(EmployeeDataRequestModel data) => json.encode(data.toJson());

class EmployeeDataRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? salary;

  EmployeeDataRequestModel({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.salary,
  });

  factory EmployeeDataRequestModel.fromJson(Map<String, dynamic> json) => EmployeeDataRequestModel(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    salary: json["salary"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "salary": salary,
  };
}
