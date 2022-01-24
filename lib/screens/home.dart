import 'dart:convert';

import 'package:faculty_info/customs/custom_internal.dart';
import 'package:faculty_info/models/department_model.dart';
import 'package:faculty_info/screens/departments/departments.dart';
import 'package:faculty_info/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var screenHeight, screenWidth;
  List<DepartmentModel>? deptNameList;

  _fetchData() async {
    final url = Uri.parse("https://raw.githubusercontent.com/absarrahman/DataStuffs/master/dept_status.json");
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
      appBar: AppBar(
        title: Text("Departments"),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
              icon: Icon(Icons.settings), onPressed: () => redirectSettings())
        ],
      ),
      body: Container(
        child: deptNameList == null
            ? loading()
            : RefreshIndicator(
                onRefresh: _refreshData,
                child: ListView.builder(
                  itemCount: deptNameList!.length + 1,
                  itemBuilder: (context, index) => index == 0
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Hero(
                            tag: "logo",
                            child: Image.asset(
                              isDark
                                  ? "assets/images/bracu_dark.png"
                                  : "assets/images/bracu_light.png",
                              height: 200,
                              width: 200,
                            ),
                          ),
                        )
                      : _departmentCard(index - 1),
                ),
              ),
      ),
    );
  }

  Future<void> _refreshData() async {
    setState(() async {
      await _fetchData();
    });
  }

  redirectSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(),
      ),
    );
  }

  Widget _departmentCard(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0,bottom: 10.0),
      child: InkWell(
        onTap: () => _redirectRoute(index),
        child: Center(
          child: Container(
            height: 74,
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
                    deptNameList![index].name ?? "N/A",
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
          deptName: deptNameList![index].name,
          deptLink: deptNameList![index].link,
        ),
      ),
    );
  }
}
