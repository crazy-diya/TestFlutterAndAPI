import 'package:company/model/employee_data_response_model.dart';
import 'package:company/server/api_helper.dart';
import 'package:company/veiws/employee_data.dart';
import 'package:flutter/material.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  State<EmployeeList> createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  List<EmployeeDataResponseModel>? list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmployeeData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Employee List Data")),
      body: SizedBox(
        height: height,
        width: width,
        child: list != null
            ? ListView.builder(
                itemCount: list!.length,
                itemBuilder: (context, index) => Card(
                    child: ListTile(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => EmployeeDataView(
                        employeeDataResponseModel: list![index]),
                  ))
                      .then((value) async {
                    await getEmployeeData();
                  }),
                  title: Text(
                      "${list![index].firstName!} ${list![index].lastName!}"),
                  subtitle: Text(list![index].email!),
                  trailing: Text(list![index].phone!),
                )),
              )
            : const Center(
                child: CircularProgressIndicator(
                strokeWidth: 4,
                color: Colors.green,
                semanticsLabel: "Loading",
              )),
      ),
    );
  }

  Future getEmployeeData() async {
    try {
      list = await APIHelper().getAllData();
      setState(() {});
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }
}
