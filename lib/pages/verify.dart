import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_ui/pages/homePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_ui/services/auth._service.dart';
import 'package:login_ui/pages/signin_page.dart';
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

  verifyEmail() async{
    if(user!=null && !user!.emailVerified){
      await user!.sendEmailVerification();
      print('Verification Email has been sent');

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Verification Email has been sent',
            style: TextStyle(fontSize: 18.0,color: Colors.amber),
          ),
      ),);
    }
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
                  Container(
                    height: 230,
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
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return 'Email cannot be empty';
                                  }
                                  if (value!.isEmpty ||
                                      !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{3,}))$').hasMatch(
                                          value!)) {
                                    return 'Enter Correct Email';
                                  }
                                  else {
                                    return null;
                                  }
                                }
                            )
                        ),
                        SizedBox(height: 30,),
                        // ElevatedButton(
                        Material(
                          child: GestureDetector
                            (
                            child: Container
                              (
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
                                      ]
                                  )
                              ),
                              child: InkWell(
                                onTap: () {
                                  if(_key.currentState!.validate()){
                                    verifyEmail();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Signed Up successfully')));
                                    const Text("Verifying Email");
                                    Navigator.pushNamed(context, MyRoutes.homeRoute);
                                  }
                                },
                                child: Padding
                                  (
                                  padding: EdgeInsets.all(11.0),
                                  child: Text('Verify Email',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),
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
