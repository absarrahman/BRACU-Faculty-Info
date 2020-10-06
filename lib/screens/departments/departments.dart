import 'dart:convert';

import 'package:faculty_info/customs/custom_internal.dart';
import 'package:faculty_info/models/faculty_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DepartmentsPage extends StatefulWidget {
  final deptName;

  DepartmentsPage(this.deptName);

  @override
  _DepartmentsPageState createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends State<DepartmentsPage> {
  var deptName, screenWidth, screenHeight;
  List<FacultyModel> list;
  List<FacultyModel> listShow;


  _fetchData() async {
    final url =
        "https://raw.githubusercontent.com/absarrahman/DataStuffs/master/faculties.json";
    var response = await http.get(url);
    return response.body;
  }

  @override
  void initState() {
    super.initState();
    deptName = widget.deptName;
    _fetchData().then((value) {
      var list = json.decode(value.toString());
      list = list[deptName];
      List<FacultyModel> listModel=[];
      for(var l in list){
        listModel.add(FacultyModel.fromJson(l));
      }
      setState(() {
        this.list = listModel;
        listShow = listModel;

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(deptName),
      ),
      body: Container(
        child: list == null
            ? loading()
            : Column(
              children: [
                _searchFaculty(),
                Expanded(
                  child: ListView.builder(
                      itemCount: listShow.length,
                      itemBuilder: (context, index) {
                        return _cardView(index);
                      },
                    ),
                ),
              ],
            ),
      ),
    );
  }

  _searchFaculty() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search....",
        ),
        onChanged: _onChanged,
      ),
    );
  }

  _onChanged(String value) {
    setState(() {
      listShow = list.where((faculty) {
        return faculty.name.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }


  Widget _cardView(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Center(
        child: Container(
          height: screenHeight * 0.20,
          width: screenWidth * 0.9,
          child: Material(
            elevation: 7,
            borderOnForeground: true,
            borderRadius: BorderRadius.circular(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      listShow[index].initial,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.14,
                ),
                Expanded(
                  child: Text(
                    listShow[index].name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.14,
                ),
                Expanded(
                  child: Text(
                    listShow[index].email,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
