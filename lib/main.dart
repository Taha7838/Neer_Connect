// ignore_for_file: prefer_const_constructors

import 'package:flutter_animate/flutter_animate.dart';
import 'package:neer_connect/login_page.dart';
import 'package:neer_connect/logo_screen.dart';
import 'package:neer_connect/registration_page.dart';
import 'package:neer_connect/screens/product.dart';
import 'package:neer_connect/utils/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main(){
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => CartProvider(),
      child: NeerConnect(),
    ),
  );
}

class NeerConnect extends StatefulWidget {
  const NeerConnect({super.key});

  @override
  State<NeerConnect> createState() => _NeerConnectState();
}

class _NeerConnectState extends State<NeerConnect> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      //home: Practice(),
      //home: const HomePage(),
      home: LogoScreen().animate().fadeIn(duration: 600.milliseconds).fadeOut(delay: 1800.milliseconds, duration: 600.milliseconds),
      routes: {
       'homepage' : (context) => ProductsPage(),
        'loginpage' : (context) => const LoginPage(),
        'registrationpage' : (context) => const RegistrationPage(),
      },
    );
  }
}
