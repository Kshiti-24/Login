import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/services/auth._service.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:flutter/src/material/scaffold.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';
class SignInPage extends StatefulWidget {


  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  bool _isHidden = true;
  String email="";
  String password="";
  String username="";
  String phone="";
  bool loading = false;
  final auth=FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
              gradient: LinearGradient(
                  colors: [Colors.yellow,Colors.orange,Colors.red]
              )
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30,),
                  // Image.asset('assets/images/sign.png'),
                  Lottie.asset('assets/images/sign.json'),
                  SizedBox(height: 5,),
                  Container(
                    height: 600,
                    width: 325,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 5,),
                        AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText('Greetings',
                                textStyle: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                )),
                          ],
                          repeatForever : true,
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
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                if(value!.isEmpty){
                                  return 'Username cannot be empty';
                                }
                                  if (value!.isEmpty ||
                                      !RegExp(r'^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$').hasMatch(
                                          value!)) {
                                    return 'Enter Correct Username';
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
                            )
                        ),
                        Container(
                            width: 250,
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: _isHidden,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                suffixIcon: Icon(Icons.lock,color: Colors.black,size: 17,
                                ),
                                hintText: 'Enter your password',
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
                                    return 'Enter Correct password';
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
                                labelText: 'Phone Number',
                                suffixIcon: Icon(Icons.phone,color: Colors.black,size: 17,
                                ),
                                hintText: 'Enter your phone number',
                              ),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly],
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return 'Phone number cannot be empty';
                                  }
                                  if (value!.isEmpty ||
                                      !RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(
                                          value!)) {
                                    return 'Enter valid Phone Number';
                                  }
                                  else {
                                    return null;
                                  }
                                }
                            )
                        ),
                        SizedBox(height: 20,),
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
                                onTap: () async {
                                  setState(() {
                                    loading=true;
                                  });
                                  if(_key.currentState!.validate()) {
                                    User? result = await AuthService().register(
                                        emailController.text,
                                        passwordController.text, context);
                                    if (result != null) {
                                      print("Success");
                                      print(result.email);
                                      Navigator.pushNamed(
                                          context, MyRoutes.verifyRoute);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(
                                              'Please verify your email')));
                                    }
                                    const Text("Signing Up");
                                  }
                                  setState(() {
                                    loading=false;
                                  });
                                },
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
                        SizedBox(
                          height: 10,
                        ),
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
