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
  String password="";
  var confirmpass;
  bool loading=false;
  String _email="";
  final auth=FirebaseAuth.instance;
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
              gradient: LinearGradient(
                  colors: [Colors.green,Colors.teal,Colors.blue]
              )
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                  // Image.asset('assets/images/forgot.png'),
                  Lottie.asset('assets/images/forgot.json'),
                  SizedBox(height: 10,),
                  Container(
                    height: 320,
                    width: 325,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Text('Send password change link',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black26
                          ),
                        ),
                        SizedBox(height: 20,),
                        AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('No Problem',
                                textStyle: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                )),
                          ],
                          repeatForever : true,
                        ),
                        SizedBox(height: 20,),
                        Container(
                            width: 250,
                            child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  suffixIcon: Icon(Icons.email,color: Colors.black,size: 17,
                                  ),
                                  hintText: 'Enter your email',
                                ),
                            )
                        ),
                        SizedBox(height: 30,),
                        ElevatedButton.icon(
                          style: TextButton.styleFrom(minimumSize: Size(100, 40)),
                          icon: Icon(Icons.email_outlined),
                          label: (const Text(
                            'Send Link',
                            style: TextStyle(fontSize: 24),
                          )),
                          onPressed: () => resetPassword(),
                        ),
                        SizedBox(
                          height: 10,
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
        builder: (context) => Center(child: CircularProgressIndicator())
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      Utils.showSnackBar('Password Reset Email sent!');

    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.toString());
    }
    Utils.showSnackBar('Password Reset Email sent!');
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
