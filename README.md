
# SecondSplash

Implemented a flutter splash for a smooth transition after the native splash ends.

[![MIT License](https://img.shields.io/apm/l/atomic-design-ui.svg?)](https://github.com/tterb/atomic-design-ui/blob/master/LICENSEs)

## Why Use This Plugin


Most plugins I've found use a timer to close the splash screen, so you have to guess the number of seconds it will take before the splashscreen closes. this plugin is made to cover this shortcoming, where the splash can be closed manually when you think everything is ready to be displayed.


> This is Not Native Splash Screen
> Use this plugin with other native splash screen for best result


### How To Close SplashScreen
First init the splash controller
```dart
SplashController splashController = SplashController();
```

Then add controller to splashscreen
```dart
SecondSplash(
    controller: splashController,
    ...
```

When you ready, close splashscreen
```dart
splashController.close();
```


## Usage/Examples

```dart
import 'package:flutter/material.dart';

import 'package:secondsplash/secondsplash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page/auth.dart';
import 'page/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SplashController splashController = SplashController();

  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    // use for checking if user is logged in or not
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedIn = prefs.getBool("loggedIn") ?? false;
    });

    // close splashscreen when ready
    splashController.close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecondSplash(
        controller: splashController,

        // systemUiOverlayStyle: SystemUiOverlayStyle(
        //   statusBarColor: Colors.transparent,
        //   statusBarBrightness: Brightness.light,
        //   systemNavigationBarColor: Colors.white,
        //   systemNavigationBarIconBrightness: Brightness.dark,
        // ),

        // decoration: BoxDecoration(
        //   color: Colors.white,
        // ),

        // child: Center(
        //   child: Container(
        //     height: 60,
        //     child: Column(
        //       children: [
        //         Container(
        //           width: 20,
        //           height: 20,
        //           child: CircularProgressIndicator(
        //             color: Colors.white,
        //             strokeWidth: 1,
        //           ),
        //         ),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         Text(
        //           "Loading Data",
        //           style: TextStyle(
        //             color: Colors.white,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),

        next: loggedIn ? Home() : Auth(),
      ),
    );
  }
}

```
