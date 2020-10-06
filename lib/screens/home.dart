import 'package:faculty_info/customs/custom_internal.dart';
import 'package:faculty_info/screens/departments/departments.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}


enum Departments{CSE, EEE, ARCH,BBS, MNS, ENH,}

class _HomePageState extends State<HomePage> {

  var screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    checkTheme(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            _departmentCard(Departments.CSE)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text("*"),
        onPressed: () => changeBrightness(context),
      ),
    );
  }

  Widget _departmentCard(Departments departments) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: InkWell(
        onTap: () => _redirectRoute(departments),
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _displayDepartment(departments),
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

  void _redirectRoute(Departments d) {
    switch(d) {
      case Departments.CSE:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DepartmentsPage("CSE")
        ));
    }

  }

  String _displayDepartment(Departments d) {
    switch(d) {
      case Departments.CSE:
        return "CSE";
        break;
      default:
        return "Null";
        break;
    }
  }
}
