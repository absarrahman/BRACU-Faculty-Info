import 'dart:convert';

import 'package:faculty_info/customs/custom_internal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DepartmentsPage extends StatefulWidget {
  final deptName;

  DepartmentsPage(this.deptName);

  @override
  _DepartmentsPageState createState() => _DepartmentsPageState();
}

class _DepartmentsPageState extends State<DepartmentsPage> {
  var list, deptName, listShow, screenWidth, screenHeight;


  TextEditingController _searchController = new TextEditingController();


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
      setState(() {
        this.list = list;
      });
    });
    _searchController.addListener(() {
      _searchFilter();
    });
  }

  _searchFilter() {
    var _faculties = list;

    if (_searchController.text.isNotEmpty) {
      _faculties.retainWhere((faculty){
        return faculty["name"].toString().toLowerCase().contains(_searchController.text.toLowerCase());
      });
    }

    setState(() {
      listShow = _faculties;
    });

  }

  @override
  Widget build(BuildContext context) {
    bool _isSearch = _searchController.text.isNotEmpty;
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
                      itemCount: _isSearch?listShow.length:list.length,
                      itemBuilder: (context, index) {
                        var fac = _isSearch?listShow[index]:list[index];
                        return _cardView(fac);
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
        controller: _searchController,
      ),
    );
  }


  Widget _cardView(list) {
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
                      list["initial"],
                    ),
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.14,
                ),
                Expanded(
                  child: Text(
                    list["name"],
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
                    list["email"],
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
