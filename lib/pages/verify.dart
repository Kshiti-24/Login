import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/pages/homepage2.dart';
import 'package:login_ui/utils/routes.dart';
import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  User? user = FirebaseAuth.instance.currentUser;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String email = "";

  moveToHome(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.homeRoute);
  }

  moveToSignIn(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.signInRoute);
  }

  moveToPassword(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.passwordRoute);
  }

  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();

    // user needs to be created before
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? NewHomePage()
      : Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.teal),
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Lottie.asset('assets/images/verify.json', height: 250),
                      SizedBox(
                        height: 29,
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText('Authentication',
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              )),
                        ],
                        repeatForever: true,
                      ),
                      SizedBox(
                        height: 29,
                      ),
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
                            Text(
                              'Enter your email for verification',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black26),
                            ),
                            SizedBox(
                              height: 29,
                            ),
                            GestureDetector(
                              child: InkWell(
                                onTap: () => NewHomePage(),
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
                                            Colors.teal
                                          ])),
                                  child: Padding(
                                    padding: EdgeInsets.all(11.0),
                                    child: Text(
                                      'Send Link',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
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
