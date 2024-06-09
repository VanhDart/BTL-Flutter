import 'package:flutter/material.dart';
import 'package:flutter_application_5/page/home_page.dart';
import 'package:flutter_application_5/page/signup_page.dart';
import 'package:flutter_application_5/services/alert_service.dart';
import 'package:flutter_application_5/services/auth_services.dart';
import 'package:flutter_application_5/wedgets/button.dart';
import 'package:flutter_application_5/wedgets/show_error.dart';
import 'package:flutter_application_5/wedgets/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isloading = false;

  void loginUsers() async {
    String res = await AuthServices().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );
    // nếu đăng nhạp thành công điều hướng đến màn hình tiếp theo
    // nếu không thì hiển thị thông báo lỗi
    if (res == "Successfulley") {
      setState(() {
        isloading = true;
      });
      // navigate
       AlertService().showToast(
        context: context, 
        text: "User Logged in successfully", 
        icon: Icons.check
      );
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
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
                height: height / 2.7,
                child: Image.asset("images/login2.jpg"),
              ),
              TextFieldLog(
                textEditingController: emailController,
                hintText: "Enter your email",
                icon: Icons.email,
              ),
              TextFieldLog(
                textEditingController: passwordController,
                hintText: "Enter your password",
                isPass: true,
                icon: Icons.lock,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              MyButton(
                onTab: loginUsers,
                text: "Log In",
              ),
              SizedBox(
                height: height / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have am account? ",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage()
                        )
                      );
                    },
                    child: const Text(
                      "SignUp",
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
