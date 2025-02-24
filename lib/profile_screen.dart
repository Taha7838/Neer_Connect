import 'package:first_app/profile_option.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'widgets/profile_option.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ProfileOption(icon: Icons.location_on, text: "Address"),
            ProfileOption(icon: Icons.account_balance_wallet, text: "Wallet"),
            ProfileOption(icon: Icons.list_alt, text: "Your Orders"),
            ProfileOption(icon: Icons.payment, text: "Payment"),
            ProfileOption(icon: Icons.logout, text: "Logout"),
            ProfileOption(icon: Icons.help, text: "Help"),
            ProfileOption(icon: Icons.info_outline, text: "About us"),
            ProfileOption(icon: Icons.ios_share_rounded, text: "Share the neer"),
          ],
        ),
      ),
    );
  }
}