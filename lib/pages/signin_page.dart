import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

 class SignInScreen extends StatefulWidget {
   const SignInScreen({Key? key}) : super(key: key);
 
   @override
   State<SignInScreen> createState() => _SignInScreenState();
 }
 
 class _SignInScreenState extends State<SignInScreen> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Container(
         decoration: BoxDecoration(
           gradient: LinearGradient(
               colors: [Colors.yellow, Colors.orange, Colors.red],
               begin: Alignment.topCenter,
               end: Alignment.bottomCenter)),
         child: SingleChildScrollView(
           // child: Padding(
           //   padding: EdgeInsets.fromLTRB(20,MediaQuery.of(context).size.height * 0.2,100,0),
             child: Column(
               children: <Widget>[
                 logoWidget("assets/images/sign.png")
               ],
             ),
           ),
         ),
     );
   }
   Image logoWidget (String imageName)
   {
     return Image.asset(
       imageName,
       fit: BoxFit.fitWidth,
       width: 240,
       height: 248,
       color: Colors.white10,
     );
   }
 }
 