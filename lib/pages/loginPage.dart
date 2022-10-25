import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_ui/pages/homePage.dart';
import 'package:flutter/src/material/scaffold.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_ui/services/auth._service.dart';
import 'package:login_ui/pages/loginPage.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool _isHidden = true;
  String email="";
  String password="";
  final auth=FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  moveToHome(BuildContext context) async {
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
  }
  moveToSignIn(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.signInRoute);
  }
  moveToPassword(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.passwordRoute);
  }
  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red,Colors.pink,Colors.purple]
            )
          ),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                Image.asset('assets/images/login.png'),
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
                  height: 450,
                  width: 325,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 30,),
                      Text('Greetings',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                  SizedBox(height: 10,),
                  Text('Enter your details to login',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black26
                  ),
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
                  ),
                  ),
                  Container(
                      width: 250,
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          suffixIcon: Icon(Icons.lock,color: Colors.black,size: 17,),
                          suffix: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(
                              _isHidden ? Icons.visibility_off : Icons.visibility,
                            ),
                          )
                        ),
                       autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
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
                  InkWell(
                    onTap: () => moveToPassword(context),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 20, 40, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Forget Password ?',
                          style: TextStyle(
                            color: Colors.orangeAccent[700]
                          ),
                          )
                        ],
                      ),
                    ),
                  ),
                      SizedBox(height: 1,),
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
                                   onTap: () async {
                                     if (_key.currentState!.validate()) {
                                       ScaffoldMessenger.of(context)
                                           .showSnackBar(
                                           SnackBar(content: Text(
                                               'Logged In successfully')));
                                       User? result = await AuthService()
                                           .login(emailController.text,
                                           passwordController.text, context);
                                       if (result != null) {
                                         print("Success");
                                         print(result.email);
                                         Navigator.pushNamed(context, MyRoutes.homeRoute);
                                       }
                                       const Text("Logging In");
                                     }
                                   },

                                   child: Padding
                                     (
                                       padding: EdgeInsets.all(11.0),
                                       child: Text('Login',
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
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () => moveToSignIn(context),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 15, 30, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Dont have an acoount ?',
                                style: TextStyle(
                                    color: Colors.orangeAccent[700]
                                ),
                              ),
                              Text(' Sign Up',
                                style: TextStyle(
                                    color: Colors.cyan,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )
                            ],
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
    );
    }
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
  }
