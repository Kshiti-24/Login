import 'package:flutter/material.dart';
import 'package:login_ui/services/auth._service.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AddLoginPage extends StatefulWidget {
  const AddLoginPage({Key? key}) : super(key: key);

  @override
  State<AddLoginPage> createState() => _AddLoginPageState();
}

class _AddLoginPageState extends State<AddLoginPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool loading=false;
  String phone="";
  final auth=FirebaseAuth.instance;
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
                  Image.asset('assets/images/sign.png'),
                  SizedBox(height: 25,),
                  Container(
                    height: 275,
                    width: 325,
                    decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 25,),
                        Text('Greetings',
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 15,),
                        Text('Click on the link below',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white60
                          ),
                        ),
                        SizedBox(height: 15,),
                        Divider(),
                        SizedBox(height: 15,),
                        SignInButton(
                            Buttons.Google,
                            text: 'Continue with Google',
                            onPressed: ()async{
                              setState(() {
                                loading=true;
                              });
                              User? result = await AuthService().signInWithGoogle();
                              if (result != null) {
                              print("Success");
                              print(result.email);
                              Navigator.pushNamed(context, MyRoutes.newHomeRoute);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logged In successfully')));
                              }
                              const Text("Logging In");
                              setState(() {
                                loading=false;
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
