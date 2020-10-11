import 'package:faculty_info/customs/custom_internal.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: primaryColor,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _changeTheme(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _reportBug(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reportBug() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Report a bug? ",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        InkWell(
          onTap: _reportMail,
          child: Text(
              "Tap here to report",
            style: TextStyle(
              color: isDark ? Colors.blue[400] : Colors.blue,
              fontSize: 20,
            ),
          ),
        ),
      ],
    );
  }

  _reportMail() async {
      var url = "mailto:moh.absar.rahman@g.bracu.ac.bd?subject=Bug report about "
          "BRACU Faculty List app";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw "Failed";
      }
  }

  Widget _changeTheme() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Change theme ",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Switch(
          value: isDark,
          onChanged: (changedValue) {
            setState(() {
              if(isDark) {
                isDark = false;
              } else {
                isDark = true;
              }
              changeBrightness(context);
            });
          },
        ),
      ],
    );
  }
}
