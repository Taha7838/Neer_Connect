// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
                Color.fromARGB(255, 30, 76, 154),
                Color.fromARGB(255, 22, 133, 122),
                Color.fromARGB(255, 22, 103, 140),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 200,
                    child: Image.asset("assets/app_logo.png"),
                ),
              ],
            ),
          ),
          ),
        ),
      );
  }
}
