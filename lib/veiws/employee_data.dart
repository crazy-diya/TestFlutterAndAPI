import 'package:company/model/employee_data_response_model.dart';
import 'package:company/veiws/data_display.dart';
import 'package:flutter/material.dart';

import '../model/employee_data_request_model.dart';
import '../server/api_helper.dart';

class EmployeeDataView extends StatefulWidget {
  EmployeeDataResponseModel? employeeDataResponseModel;

  EmployeeDataView({Key? key, this.employeeDataResponseModel})
      : super(key: key);

  @override
  State<EmployeeDataView> createState() => _EmployeeDataViewState();
}

class _EmployeeDataViewState extends State<EmployeeDataView> {
  bool edit = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController salary = TextEditingController();
  final _formKey2 = GlobalKey<FormState>();

  bool isSuccess = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.employeeDataResponseModel!.firstName!} Details "),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: isSuccess
              ? Form(
                  key: _formKey2,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        edit
                            ? Column(
                                children: [
                                  TextFormField(
                                    controller: firstName,
                                    decoration: const InputDecoration(
                                        hintText: "Enter First Name :"),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: lastName,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Last Name :"),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter some text';
                                      }
                                      return null;
                                    },
                                  )
                                ],
                              )
                            : Text(
                                "${widget.employeeDataResponseModel!.firstName!} ${widget.employeeDataResponseModel!.lastName!}",
                                style: const TextStyle(fontSize: 18)),
                        const SizedBox(
                          height: 20,
                        ),
                        edit
                            ? TextFormField(
                                controller: email,
                                decoration: const InputDecoration(
                                    hintText: "Enter Email Number :"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              )
                            : Text(widget.employeeDataResponseModel!.email!,
                                style: const TextStyle(fontSize: 18)),
                        const SizedBox(
                          height: 20,
                        ),
                        edit
                            ? TextFormField(
                                controller: phone,
                                decoration: const InputDecoration(
                                    hintText: "Enter Phone Number :"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              )
                            : Text(widget.employeeDataResponseModel!.phone!,
                                style: const TextStyle(fontSize: 18)),
                        const SizedBox(
                          height: 20,
                        ),
                        edit
                            ? TextFormField(
                                controller: salary,
                                decoration: const InputDecoration(
                                    hintText: "Enter Salary :"),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                              )
                            : Text(widget.employeeDataResponseModel!.salary!,
                                style: const TextStyle(fontSize: 18)),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              edit = !edit;
                            });
                            if (edit) {
                              setState(() {
                                firstName.text = widget
                                    .employeeDataResponseModel!.firstName!;
                                lastName.text =
                                    widget.employeeDataResponseModel!.lastName!;
                                email.text =
                                    widget.employeeDataResponseModel!.email!;
                                phone.text =
                                    widget.employeeDataResponseModel!.phone!;
                                salary.text =
                                    widget.employeeDataResponseModel!.salary!;
                              });
                            } else {
                              if (_formKey2.currentState!.validate()) {
                                setState(() {
                                  isSuccess = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Updating Data')),
                                );

                                var response = await APIHelper().put(
                                    EmployeeDataRequestModel(
                                      firstName: firstName.text,
                                      lastName: lastName.text,
                                      email: email.text,
                                      phone: phone.text,
                                      salary: salary.text,
                                    ),
                                    widget.employeeDataResponseModel!.id!);
                                print(response);
                                if (response.statusCode == 200) {
                                  setState(() {
                                    isSuccess = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Success')),
                                  );
                                  setState(() {
                                    widget.employeeDataResponseModel!
                                        .firstName = firstName.text;
                                    widget.employeeDataResponseModel!.lastName =
                                        lastName.text;
                                    widget.employeeDataResponseModel!.email =
                                        email.text;
                                    widget.employeeDataResponseModel!.phone =
                                        phone.text;
                                    widget.employeeDataResponseModel!.salary =
                                        salary.text;
                                  });
                                } else {
                                  print(response.statusMessage);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(response.statusMessage)),
                                  );
                                }
                              }
                            }
                          },
                          child: Text(edit ? "Save" : "Edit"),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              var response = await APIHelper().delete(
                                  widget.employeeDataResponseModel!.id!);
                              print(response);
                              if (response.statusCode == 200) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Successfully Deleted')),
                                );
                                Navigator.pop(context);
                              } else {
                                print(response.statusMessage);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(response.statusMessage)),
                                );
                              }
                            },
                            child: const Text("Delete"))
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: Colors.green,
                  semanticsLabel: "Loading",
                )),
        ),
      ),
    );
  }
}
