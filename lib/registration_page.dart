// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neer_connect/utils/spaces.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isValidated = false;

  Future<void> registerUser() async {
    if (usernameController.text.isNotEmpty && emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/register'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": usernameController.text,
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful!")),
        );
        Navigator.pushReplacementNamed(
            context, 'loginpage', arguments: usernameController.text);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Failed")),
        );
      }
    } else {
      _isValidated = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blueAccent,
                Colors.teal,
                Colors.lightBlue,
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'WELCOME',
                      style: GoogleFonts.acme(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    VerticalSpacing(20),

                    //Registration page illustration
                    Image.asset("assets/app_logo.png",),

                    VerticalSpacing(20),

                    //Username field
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        errorText: _isValidated? "Username is required!" : null,
                        errorStyle: GoogleFonts.acme(
                          color: Colors.red[800],
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          )
                        ),
                        labelText: "Username",
                        labelStyle: GoogleFonts.acme(
                          fontSize: 25,
                          color: Colors.grey[800],
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    VerticalSpacing(20),

                    //Email field
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        errorText: _isValidated? "Email is required!" : null,
                        errorStyle: GoogleFonts.acme(
                          color: Colors.red[800],
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.black,
                            )
                        ),
                        labelText: "Email",
                        labelStyle: GoogleFonts.acme(
                          fontSize: 25,
                          color: Colors.grey[800],
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    VerticalSpacing(20),

                    //Password Field
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        errorText: _isValidated? "Password is required!" : null,
                        errorStyle: GoogleFonts.acme(
                          color: Colors.red[800],
                        ),
                        labelText: "Password",
                        labelStyle: GoogleFonts.acme(
                          fontSize: 25,
                          color: Colors.grey[800],
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                              width: 3,
                              color: Colors.black,
                            )
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                            width: 3,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    VerticalSpacing(20),

                    //Login Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        side: const BorderSide(
                          color: Colors.brown,
                          width: 2,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                      ),
                      onPressed: () {
                        registerUser();
                      },
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Text('Register',
                        style: GoogleFonts.acme(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),

                    VerticalSpacing(20),

                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, 'loginpage');
                      },
                      child: Text('Already a user? LOGIN',
                      style: GoogleFonts.acme(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
