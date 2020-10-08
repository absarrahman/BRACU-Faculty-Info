import 'dart:io';

import 'package:faculty_info/customs/custom_internal.dart';
import 'package:faculty_info/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:transparent_image/transparent_image.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var screenHeight, screenWidth;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Future.delayed(
      Duration(
        seconds: 4,
      ),
          () => _checkConnection(),
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    checkTheme(context);
    return Scaffold(
      body: Center(
        child: FadeInImage(
          placeholder: MemoryImage(kTransparentImage),
          image: AssetImage(isDark?
            "assets/images/bracu_dark.png":"assets/images/bracu_light.png",
          ),
          fit: BoxFit.fill,
          height: screenHeight * 0.3,
          width: screenHeight * 0.3,
          fadeInDuration: Duration(
            seconds: 1
          ),
        ),
      ),
    );
  }

  _checkConnection () async {
    try {
      final checkConnectionAvailable = await InternetAddress.lookup("www.google.com");
      if (checkConnectionAvailable.isNotEmpty && checkConnectionAvailable[0].rawAddress.isNotEmpty) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
                (e) => false);
      }
    } on SocketException catch (_) {
      _exitApp();
    }
  }

  _exitApp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        title: Text(
          "BRACU Faculty List App",
          textAlign: TextAlign.center,
        ),
        content: Container(
          height: 150,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: LottieBuilder.asset(
                  "assets/animations/sad-animation.json",
                  height: 50,
                  width: 50,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Internet connection not available. "
                    "Please connect with the internet and try again",
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Ok",
            ),
            onPressed: () => exit(0),
          ),
        ],
      ),
    );
  }

}
