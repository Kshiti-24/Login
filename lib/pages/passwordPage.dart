import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:login_ui/utils/utils.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:login_ui/services/auth._service.dart';
import 'package:lottie/lottie.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool _isHidden = true;
  String password = "";
  var confirmpass;
  bool loading = false;
  String _email = "";
  final auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  moveToHome(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.homeRoute);
  }

  moveToLogin(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.loginRoute);
  }

  moveToPassword(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.passwordRoute);
  }

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
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
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  // Image.asset('assets/images/forgot.png'),
                  Lottie.asset('assets/images/forgot.json',height: 250),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.7,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(90),
                          topRight: Radius.circular(90),
                        ),),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 29,
                        ),
                        Text(
                          'Change Password',
                          style: TextStyle(fontSize: 25, color: Colors.black26),
                        ),
                        SizedBox(
                          height: 29,
                        ),
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText('No Problem',
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
                            width: 250,
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                  size: 17,
                                ),
                                hintText: 'Enter your email',
                              ),
                            )),
                        SizedBox(
                          height: 29,
                        ),
                        GestureDetector(
                          child: Container(
                            alignment: Alignment.center,
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                colors:[ Colors.tealAccent,Colors.teal]
                              )
                            ),
                            child: InkWell(
                              onTap: ()=>resetPassword(),
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
                        SizedBox(
                          height: 29,
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

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Password Reset Email sent!');
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.toString());
    }
    Utils.showSnackBar('Password Reset Email sent!');
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
