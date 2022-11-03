import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'homepage2.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class NewLoginPage extends StatefulWidget {
  @override
  _NewLoginPageState createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool loading = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  User? user;
  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // margin: EdgeInsets.all(10),
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
                  Lottie.asset('assets/images/otp.json', height: 250),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(90),
                        topRight: Radius.circular(90),
                      ),
                    ),
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
                        Container(
                            width: 250,
                            child: TextFormField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  hintText: 'Enter your phone number',
                                  labelText: "Phone Number",
                                  prefix: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Text('+91'),
                                  ),
                                ),
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Phone number cannot be empty';
                                  }
                                  if (value!.isEmpty ||
                                      !RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                          .hasMatch(value!)) {
                                    return 'Enter valid Phone Number';
                                  } else {
                                    return null;
                                  }
                                })),
                        SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          child: Container(
                            width: 250,
                            child: TextFormField(
                                controller: otpController,
                                decoration: InputDecoration(
                                  hintText: 'Enter your OTP',
                                  labelText: "OTP",
                                  prefix: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Text(''),
                                  ),
                                ),
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'OTP cannot be empty';
                                  }
                                  if (value.length != 6) {
                                    return "OTP should be of 6 digits";
                                  } else {
                                    return null;
                                  }
                                }),
                          ),
                          visible: otpVisibility,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        loading
                            ? CircularProgressIndicator()
                            : Material(
                                child: GestureDetector(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (_key.currentState!.validate()) {
                                        if (otpVisibility) {
                                          verifyOTP();
                                        } else {
                                          loginWithPhone();
                                        }
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 250,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Colors.tealAccent,
                                                Colors.teal,
                                              ])),
                                      child: Padding(
                                        padding: EdgeInsets.all(11.0),
                                        child: Text(
                                          otpVisibility ? "Verify" : "Login",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
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

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
      (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser!;
        });
      },
    ).whenComplete(
      () {
        user ??
            Fluttertoast.showToast(
              msg: "You are logged in successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NewHomePage(),
          ),
        );
      },
    );
  }
}
