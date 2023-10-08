// To parse this JSON data, do
//
//     final employeeDataResponseModel = employeeDataResponseModelFromJson(jsonString);

import 'dart:convert';

List<EmployeeDataResponseModel> employeeDataResponseModelFromJson(String str) => List<EmployeeDataResponseModel>.from(json.decode(str).map((x) => EmployeeDataResponseModel.fromJson(x)));

String employeeDataResponseModelToJson(List<EmployeeDataResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeDataResponseModel {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? salary;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  EmployeeDataResponseModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.salary,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory EmployeeDataResponseModel.fromJson(Map<String, dynamic> json) => EmployeeDataResponseModel(
    id: json["_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    salary: json["salary"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "salary": salary,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
