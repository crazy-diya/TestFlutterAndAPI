import 'package:company/model/employee_data_request_model.dart';
import 'package:company/model/employee_data_response_model.dart';
import 'package:company/server/api_helper.dart';
import 'package:company/veiws/data_display.dart';
import 'package:flutter/material.dart';

class DataInsertView extends StatefulWidget {
  String title;

  DataInsertView({Key? key, required this.title}) : super(key: key);

  @override
  State<DataInsertView> createState() => _DataInsertViewState();
}

class _DataInsertViewState extends State<DataInsertView> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextFormField(
                  controller: firstName,
                  decoration:
                      const InputDecoration(hintText: "Enter First Name :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: lastName,
                  decoration:
                      const InputDecoration(hintText: "Enter Last Name :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: email,
                  decoration:
                      const InputDecoration(hintText: "Enter Email Number :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: phone,
                  decoration:
                      const InputDecoration(hintText: "Enter Phone Number :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                  controller: salary,
                  decoration: const InputDecoration(hintText: "Enter Salary :"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );

                          var response = await APIHelper().post(
                            EmployeeDataRequestModel(
                              firstName: firstName.text,
                              lastName: lastName.text,
                              email: email.text,
                              phone: phone.text,
                              salary: salary.text,
                            ),
                          );
                          print(response);
                          if (response.statusCode == 200) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Success')),
                            );
                            _formKey.currentState!.reset();
                          } else {
                            print(response.statusMessage);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(response.statusMessage)),
                            );
                          }
                        }
                      },
                      child: const Text("SUBMIT DATA"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const EmployeeList(),
                          ),
                        );
                      },
                      child: const Text("EMPLOYEE LIST"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
