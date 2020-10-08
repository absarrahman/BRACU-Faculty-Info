import 'package:faculty_info/customs/custom_internal.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Change theme "),
                SizedBox(
                  width: 20,
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
            )
          ],
        ),
      ),
    );
  }
}
