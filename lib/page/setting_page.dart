
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_5/page/login_page.dart';
import 'package:flutter_application_5/services/alert_service.dart';
import 'package:flutter_application_5/services/auth_services.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              bool result = await AuthServices().logoutUse();
              if (result) {
                AlertService().showToast(
                  // ignore: use_build_context_synchronously
                  context: context, 
                  text: "Logout successfully", 
                  icon: Icons.check
                );
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              }
            },
            icon: const Icon(
              color: Colors.red,
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Container(
        
      ),
    );
  }
}
