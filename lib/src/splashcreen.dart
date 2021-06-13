import 'package:flutter/material.dart';

/// Default splashscreen used if no one available
class DefaultSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          height: 60,
          child: Column(
            children: [
              Container(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 1,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Loading Data",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
