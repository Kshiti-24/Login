import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_ui/pages/homePage.dart';
class PasswordPage extends StatefulWidget {
  const PasswordPage({Key? key}) : super(key: key);

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  String password="";
  var confirmpass;
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
                  Image.asset('assets/images/forgot.png'),
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
                        Text('Set your new password here',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black26
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                            width: 250,
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'New Password',
                                suffixIcon: Icon(Icons.lock,color: Colors.black,size: 17,
                                ),
                                hintText: 'Enter your new password',
                              ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                confirmpass= value ;
                                  if(value!.isEmpty){
                                    return 'Passsord cannot be empty';
                                  }
                                  else if (value.length < 8) {
                                    return "Password must be atleast 8 characters long";
                                  }
                                  else if (value!.isEmpty ||
                                      !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(
                                          value!)) {
                                    return 'Enter Correct Password';
                                  }
                                  else {
                                    return null;
                                  }
                                }
                            )
                        ),
                        Container(
                            width: 250,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Confirm new Password',
                                suffixIcon: Icon(Icons.lock,color: Colors.black,size: 17,
                                ),
                                hintText: 'Enter your new password',
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please Re-Enter New Password";
                                } else if (value.length < 8) {
                                  return "Password must be atleast 8 characters long";
                                } else if (value!= confirmpass) {
                                  return "Password must be same as above";
                                } else {
                                  return null;
                                }
                              },
                            )
                        ),
                        SizedBox(height: 20,),
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
                                    const Text("Setting new password");
                                    Navigator.pushNamed(context, MyRoutes.loginRoute);
                                  }
                                },
                                child: Padding
                                  (
                                  padding: EdgeInsets.all(11.0),
                                  child: Text('Save Changes',
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
