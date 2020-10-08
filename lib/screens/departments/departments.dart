import 'dart:convert';

import 'package:faculty_info/customs/custom_internal.dart';
import 'package:faculty_info/models/faculty_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class DepartmentsPage extends StatefulWidget {
  final deptName;
  final deptLink;

  DepartmentsPage({this.deptName,this.deptLink});

  @override
  _DepartmentsPageState createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends State<DepartmentsPage> {
  var deptName, screenWidth, screenHeight;
  List<FacultyModel> list;
  List<FacultyModel> listShow;

  _fetchData() async {
    final url =
        widget.deptLink;
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
      List<FacultyModel> listModel = [];
      for (var l in list) {
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

  Widget _typeWidget(int index) {
    return Radio(value: index, groupValue: null, onChanged: (val)=>{});
  }

  _searchFaculty() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          hintText: "Search....",
        ),
        onChanged: _onChanged,
      ),
    );
  }

  _onChanged(String value) {
    setState(() {
      listShow = list.where((faculty) {
        return ((faculty.name.toLowerCase().contains(value.toLowerCase()))||(faculty.initial.toLowerCase().contains(value.toLowerCase())));
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
            color: isDark ? Color(0xff6b6b6b) : Colors.white,
            elevation: 7,
            borderOnForeground: true,
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${listShow[index].initial}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${listShow[index].name}",
                    style: TextStyle(
                      fontSize: 20,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => _launchEmail(listShow[index].email),
                    child: Text(
                      "${listShow[index].email}",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                        color: isDark ? Colors.blue[400] : Colors.blue,
                      ),
                      textAlign: TextAlign.center,
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

  _launchEmail(String mail) async {
    var url = "mailto:$mail";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Failed";
    }
  }
}
