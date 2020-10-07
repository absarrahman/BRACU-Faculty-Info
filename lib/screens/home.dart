import 'dart:convert';

import 'package:faculty_info/customs/custom_internal.dart';
import 'package:faculty_info/models/department_model.dart';
import 'package:faculty_info/screens/departments/departments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var screenHeight, screenWidth;
  List<DepartmentModel> deptNameList;

  _fetchData() async {
    final url =
        "https://raw.githubusercontent.com/absarrahman/DataStuffs/master/dept_status.json";
    var response = await http.get(url);
    return response.body;
  }

  @override
  void initState() {
    super.initState();
    _fetchData().then((value) {
      var list = json.decode(value.toString());
      list = list["dept"];
      List<DepartmentModel> listModel = [];
      for (var l in list) {
        listModel.add(DepartmentModel.fromJson(l));
      }
      setState(() {
        deptNameList = listModel;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    checkTheme(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: deptNameList == null
            ? loading()
            : ListView.builder(
                itemCount: deptNameList.length,
                itemBuilder: (context, index) => _departmentCard(index),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("*"),
        onPressed: () => changeBrightness(context),
      ),
    );
  }

  Widget _departmentCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: InkWell(
        onTap: () => _redirectRoute(index),
        child: Center(
          child: Container(
            height: screenHeight * 0.20,
            width: screenWidth * 0.9,
            child: Material(
              elevation: 7,
              color: isDark ? Color(0xff424242) : Colors.white,
              borderOnForeground: true,
              borderRadius: BorderRadius.circular(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    deptNameList[index].name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _redirectRoute(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DepartmentsPage(
          deptName: deptNameList[index].name,
          deptLink: deptNameList[index].link,
        ),
      ),
    );
  }
}
