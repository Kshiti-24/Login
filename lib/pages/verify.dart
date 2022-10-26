import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/pages/homepage2.dart';
import 'package:login_ui/utils/routes.dart';
import 'dart:async';
import 'package:login_ui/utils/utils.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  User? user=FirebaseAuth.instance.currentUser;
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String email="";
  moveToHome(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.homeRoute);
  }
  moveToSignIn(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.signInRoute);
  }
  moveToPassword(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.passwordRoute);
  }

  // verifyEmail() async{
  //   if(user!=null && !user!.emailVerified){
  //     await user!.sendEmailVerification();
  //     print('Verification Email has been sent');
  //
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text('Verification Email has been sent',
  //           style: TextStyle(fontSize: 18.0,color: Colors.amber),
  //         ),
  //     ),);
  //   }
  // }
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();

    // user needs to be created before
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
            (_) => checkEmailVerified(),
      );
    }
  }

  Future sendVerificationEmail() async{
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);

    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.toString());
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
    if(isEmailVerified) timer?.cancel();
  }
  @override
  Widget build(BuildContext context) => isEmailVerified ? NewHomePage() :
   Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.cyan,Colors.blue,Colors.indigo]
              )
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                  Image.asset('assets/images/verify.png'),
                  SizedBox(height: 10,),
                  Text('My First App',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10,),
                  AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('Authentication',
                          textStyle: TextStyle(
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          )),
                    ],
                    repeatForever : true,
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 290,
                    width: 325,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Text('Enter your email for verification',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black26
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                            width: 250,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                suffixIcon: Icon(Icons.email,color: Colors.black,size: 17,
                                ),
                                hintText: 'Enter your email',
                              ),
                              //   autovalidateMode: AutovalidateMode.onUserInteraction,
                              //   validator: (value) {
                              //     if(value!.isEmpty){
                              //       return 'Email cannot be empty';
                              //     }
                              //     if (value!.isEmpty ||
                              //         !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{3,}))$').hasMatch(
                              //             value!)) {
                              //       return 'Enter Correct Email';
                              //     }
                              //     else {
                              //       return null;
                              //     }
                              //   }
                            )
                        ),
                        SizedBox(height: 30,),
                        ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size.fromHeight(50),
                                  ),
                                  icon: const Icon(Icons.email, size: 32),
                                  label: const Text(
                                    'Resend Email',
                                    style: TextStyle(fontSize: 24),
                                  ),
                            onPressed: canResendEmail ? sendVerificationEmail : null
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
