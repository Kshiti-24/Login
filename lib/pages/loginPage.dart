import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_ui/pages/homePage.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name="";
  bool changeButton=false;
  final _formKey = GlobalKey<FormState>();
  moveToHome(BuildContext context) async {
    // if(_formKey.currentState!.validate()) {
    //   setState(() {
    //     changeButton = true;
    //   });
    //   await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
    //   setState(() {
    //     changeButton = false;
    //   });
    // }
  }
  moveToSignIn(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.signInRoute);
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
              colors: [Colors.yellow,Colors.orange,Colors.red]
            )
          ),
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
                height: 400,
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
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      suffixIcon: Icon(Icons.email,color: Colors.black,size: 17,
                    ),
                      hintText: 'Enter your email',
                  ),
                    validator: (value) {
                      if(value != null && value.isEmpty){
                        return "Email cannot be empty";
                      }
                      return null;
                    },
                )
                ),
                Container(
                    width: 250,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: Icon(Icons.lock,color: Colors.black,size: 17,
                        ),
                        hintText: 'Enter your email',
                      ),
                      validator: (value) {
                        if(value!=null && value.isEmpty)
                          {
                            return "Password cannot be empty";
                          }
                        else if(value!=null && value.length<8 )
                          {
                            return "Password length should be atleast 8";
                          }
                        return null;
                      },
                      )
                    ),
                Padding(
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
                                 onTap: () => moveToHome(context),
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
                     // onPressed: (){
                     //   Navigator.pushNamed(context, MyRoutes.homeRoute);

                   
                    SizedBox(
                      height: 10,
                    ),
                    // Text('Or Login using Google',
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold
                    //   ),
                    // ),
                    // SizedBox(height: 10,),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Icon(FontAwesomeIcons.google,color: Colors.pink,),
                    //
                    //   ],
                    // )
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
    );
  }
}
