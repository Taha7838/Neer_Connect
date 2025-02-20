import 'dart:async';
import 'package:flutter/material.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {

  @override
  void initState(){
    super.initState();
    //Navigate to login screen after some seconds
    Timer(const Duration(seconds: 3), (){
      Navigator.pushReplacementNamed(context, 'loginpage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Container(
          decoration:const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 11, 61, 147),
                Color.fromARGB(255, 10, 63, 58),
                Color.fromARGB(255, 27, 68, 87),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/app_logo.png"),
              ],
            ),

          ),
          ),
        ),
      );
  }
}
