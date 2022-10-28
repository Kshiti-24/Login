import 'package:flutter/material.dart';
import 'package:login_ui/services/auth._service.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';

class AddLoginPage extends StatefulWidget {
  const AddLoginPage({Key? key}) : super(key: key);

  @override
  State<AddLoginPage> createState() => _AddLoginPageState();
}

class _AddLoginPageState extends State<AddLoginPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool loading = false;
  String phone = "";
  final auth = FirebaseAuth.instance;
  TextEditingController countryController = TextEditingController();

  moveToHome(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.homeRoute);
  }

  moveToLogin(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.loginRoute);
  }

  moveToVerify(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.verifyRoute);
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
                  // Image.asset('assets/images/sign.png'),
                  Lottie.asset('assets/images/google.json',height: 250),
                  SizedBox(
                    height: 25,
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
                        AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText('Greetings',
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
                        Text(
                          'Click on the link below',
                          style: TextStyle(fontSize: 15, color: Colors.black26),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(),
                        SizedBox(
                          height: 15,
                        ),
                        SignInButton(Buttons.Google,
                            text: 'Continue with Google', onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          User? result = await AuthService().signInWithGoogle();
                          if (result != null) {
                            print("Success");
                            print(result.email);
                            Navigator.pushNamed(context, MyRoutes.newHomeRoute);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Logged In successfully')));
                          }
                          const Text("Logging In");
                          setState(() {
                            loading = false;
                          });
                        })
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
