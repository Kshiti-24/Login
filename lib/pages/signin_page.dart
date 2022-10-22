import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_ui/pages/homePage.dart';
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
              gradient: LinearGradient(
                  colors: [Colors.yellow,Colors.orange,Colors.red]
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30,),
              Image.asset('assets/images/sign.png'),
              SizedBox(height: 5,),
              Text('My First App',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 5,),
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
                    SizedBox(height: 10,),
                    Text('Greetings',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text('Enter your details to Sign Up',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black26
                      ),
                    ),
                    SizedBox(height: 1,),
                    Container(
                        width: 250,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                            suffixIcon: Icon(Icons.verified_user,color: Colors.black,size: 17,
                            ),
                            hintText: 'Enter your username',
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
                    Container(
                        width: 250,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            suffixIcon: Icon(Icons.phone,color: Colors.black,size: 17,
                            ),
                            hintText: 'Enter your phone number',
                          ),
                          validator: (value) {
                            if(value != null && value.isEmpty){
                              return "Email cannot be empty";
                            }
                            return null;
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
                            onTap: () => moveToVerify(context),
                            child: Padding
                              (
                              padding: EdgeInsets.all(11.0),
                              child: Text('Sign Up',
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
                      onTap: () => moveToLogin(context),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 5, 5, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account ?',
                              style: TextStyle(
                                  color: Colors.orangeAccent[700]
                              ),
                            ),
                            Text(' Login',
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
