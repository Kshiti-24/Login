import 'package:flutter/material.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:flutter/services.dart';
  class NewLoginPage extends StatefulWidget {
    const NewLoginPage({Key? key}) : super(key: key);
  
    @override
    State<NewLoginPage> createState() => _NewLoginPageState();
  }
  
  class _NewLoginPageState extends State<NewLoginPage> {
    GlobalKey<FormState> _key = new GlobalKey();
    String phone="";
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
    void initState() {
      // TODO: implement initState
      countryController.text = "+91";
      super.initState();
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
                          color: Colors.white,
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
                          Text('Enter your phone number',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black26
                            ),
                          ),
                          SizedBox(height: 15,),
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
                                    if(_key.currentState!.validate()) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(
                                              'OTP sent successfully')));
                                        Navigator.pushNamed(
                                            context, MyRoutes.otpRoute);
                                      }
                                    },
                                  child: Padding
                                    (
                                    padding: EdgeInsets.all(11.0),
                                    child: Text('Send OTP',
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
  