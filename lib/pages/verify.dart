import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_ui/pages/homePage.dart';
class VerifyPage extends StatefulWidget {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
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
                          validator: (value) {
                            if(value != null && value.isEmpty){
                              return "Email cannot be empty";
                            }
                            return null;
                          },
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
                            onTap: () => moveToHome(context),
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
    );
  }
}
