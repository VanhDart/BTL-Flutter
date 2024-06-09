// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_5/page/login_page.dart';
import 'package:flutter_application_5/services/alert_service.dart';
import 'package:flutter_application_5/services/auth_services.dart';
import 'package:flutter_application_5/wedgets/button.dart';
import 'package:flutter_application_5/wedgets/show_error.dart';
import 'package:flutter_application_5/wedgets/text_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isloading = false;


  void signUpUsers() async {
    String res = await AuthServices().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );
    // nếu đăng ký thành công, người dùng đã được tạo và điều hướng đến màn hình tiếp theo
    // nếu không thì hiển thị thông báo lỗi
    if (res == "Successfulley") {
      setState(() {
        isloading = true;
      });
      // navigate
      AlertService().showToast(
        context: context, 
        text: "User registered successfully", 
        icon: Icons.check
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()));
    } else {
      setState(() {
        isloading = false;
      });
      // show error
      ShowSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: height / 2.8,
                child: Image.asset("images/signup.jpg"),
              ),
              TextFieldLog(
                textEditingController: nameController,
                hintText: "Enter your Name",
                icon: Icons.person,
              ),
              TextFieldLog(
                textEditingController: emailController,
                hintText: "Enter your Email",
                icon: Icons.email,
              ),
              TextFieldLog(
                textEditingController: passwordController,
                hintText: "Enter your Password",
                isPass: true,
                icon: Icons.lock,
              ),
              MyButton(
                onTab: signUpUsers,
                text: "Sign Up",
              ),
              SizedBox(
                height: height / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: const Text(
                      "LogIn",
                      style: TextStyle(
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
    );
  }
}
