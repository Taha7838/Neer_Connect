import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neer_connect/utils/spaces.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _notValidated = false;

  Future<void> loginUser() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text,
          "password": passwordController.text,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String username = data['userName'];
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful!')),
        );
        Navigator.pushReplacementNamed(
            context, 'homepage', arguments: username);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data["message"])));
      }
    }else{
      _notValidated = true;
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
                      'WELCOME BACK',
                      style: GoogleFonts.acme(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                
                    VerticalSpacing(20),
                
                    //Login page illustration
                    Image.asset("assets/app_logo.png",height: 300,),
                
                    VerticalSpacing(20),
                
                    //Email field
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        errorText: _notValidated ? "Email field cannot be empty" : null,
                        errorStyle: GoogleFonts.acme(
                          color: Colors.red[800],
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
                        errorText: _notValidated? "Password field cannot be empty" : null,
                        errorStyle: GoogleFonts.acme(
                          color: Colors.red[800],
                        ),
                        labelText: "Password",
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
                          loginUser();
                        },
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Text('LOGIN',
                        style: GoogleFonts.acme(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                        ),
                    ),
                
                    VerticalSpacing(20),
                
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Text('Forgot Password?',
                          style: GoogleFonts.acme(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, 'registrationpage');
                          },
                          child: Text('Sign Up',
                          style: GoogleFonts.acme(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        )
                      ],
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
