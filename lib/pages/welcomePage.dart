import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String name = "";
  bool changeButton = false;
  final _formKey = GlobalKey<FormState>();

  moveToNewLogin(BuildContext context) async {
    await Navigator.pushReplacementNamed(context, MyRoutes.newloginRoute);
  }

  moveToAddLogin(BuildContext context) async {
    await Navigator.pushReplacementNamed(context, MyRoutes.addloginRoute);
  }

  moveToSignIn(BuildContext context) async {
    await Navigator.pushReplacementNamed(context, MyRoutes.signInRoute);
  }

  moveToLogin(BuildContext context) async {
    await Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.teal,
          ),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 29,
                  ),
                  // Image.asset('assets/images/welcome.png'),
                  Lottie.asset('assets/images/welcome.json', height: 250),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90),
                        topRight: Radius.circular(90),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 29,
                        ),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText('Namaste',
                                textStyle: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                          repeatForever: true,
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        Text(
                          'Login or Sign Up',
                          style: TextStyle(fontSize: 15, color: Colors.black26),
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        // ElevatedButton(
                        Material(
                          child: GestureDetector(
                            child: InkWell(
                              onTap: () => moveToLogin(context),
                              child: Container(
                                alignment: Alignment.center,
                                width: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.tealAccent,
                                          Colors.teal,
                                        ])),
                                child: Padding(
                                  padding: EdgeInsets.all(11.0),
                                  child: Text(
                                    'Login using email',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        // ElevatedButton(
                        Material(
                          child: GestureDetector(
                            child: InkWell(
                              onTap: () => moveToNewLogin(context),
                              child: Container(
                                alignment: Alignment.center,
                                width: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.tealAccent,
                                          Colors.teal,
                                        ])),
                                child: Padding(
                                  padding: EdgeInsets.all(11.0),
                                  child: Text(
                                    'Login using OTP',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        Material(
                          child: GestureDetector(
                            child: InkWell(
                              onTap: () => moveToSignIn(context),
                              child: Container(
                                alignment: Alignment.center,
                                width: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.tealAccent,
                                          Colors.teal,
                                        ])),
                                child: Padding(
                                  padding: EdgeInsets.all(11.0),
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        Material(
                          child: GestureDetector(
                            child: InkWell(
                              onTap: () => moveToAddLogin(context),
                              child: Container(
                                alignment: Alignment.center,
                                width: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.tealAccent,
                                          Colors.teal,
                                        ])),
                                child: Padding(
                                  padding: EdgeInsets.all(11.0),
                                  child: Text(
                                    'Login using Google',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
