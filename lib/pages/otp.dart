import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:pinput/pinput.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_ui/pages/homePage.dart';
class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String name="";
  bool loading=false;
  bool changeButton=false;
  final _formKey = GlobalKey<FormState>();
  moveToHome(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.homeRoute);
  }
  moveToNewLoginPage(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.newloginRoute);
  }
  moveToSignIn(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.signInRoute);
  }
  moveToPassword(BuildContext context) async {
    await Navigator.pushNamed(context, MyRoutes.passwordRoute);
  }
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
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
              Image.asset('assets/images/verify.png'),
              SizedBox(height: 10,),
              Container(
                height: 270,
                width: 325,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10,),
                    Text('Enter your OTP for verification',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black26
                      ),
                    ),
                    SizedBox(height: 20,),
                    Pinput(
                      length: 6,
                      // defaultPinTheme: defaultPinTheme,
                      // focusedPinTheme: focusedPinTheme,
                      // submittedPinTheme: submittedPinTheme,

                      showCursor: true,
                      onCompleted: (pin) => print(pin),
                    ),
                    SizedBox(height: 30,),
                    loading ? CircularProgressIndicator() :
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
                              setState(() {
                                loading=true;
                              });
                              moveToHome(context);
                              setState(() {
                                loading=false;
                              });
                            },
                            child: Padding
                              (
                              padding: EdgeInsets.all(11.0),
                              child: Text('Verify OTP',
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
                      onTap: () => moveToNewLoginPage(context),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(15, 15, 30, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Want to edit phone number ?',
                              style: TextStyle(
                                  color: Colors.deepPurpleAccent,
                              ),
                              textAlign: TextAlign.left,
                            ),
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