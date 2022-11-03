import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:login_ui/widgets/drawer.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lottie/lottie.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Dashboard",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          actions: [
            TextButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, MyRoutes.welcomeRoute);
              },
              icon: Icon(Icons.logout),
              label: Text('Log Out'),
              style: TextButton.styleFrom(),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.teal),
            child: Center(
              child: Column(
                children: [
                  Lottie.asset('assets/images/register.json', height: 250),
                  AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('Welcome',
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          )),
                      TyperAnimatedText('Your details',
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          )),
                    ],
                    repeatForever: true,
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                  SizedBox(
                    height: 29,
                  ),
                  Text(
                   user.email != null ? "Email :" : "Phone Number : " ,
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    user.email ?? user.phoneNumber ?? " invalid",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("User Id"),
                  SizedBox(
                    height: 11,
                  ),
                  Text(
                    user.uid,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 11,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('Eat',
                          textStyle: TextStyle(
                              letterSpacing: 3,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      RotateAnimatedText('Sleep',
                          textStyle: TextStyle(
                              letterSpacing: 3,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      RotateAnimatedText(
                        'Code',
                        textStyle: TextStyle(
                            letterSpacing: 3,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      RotateAnimatedText(
                        'Repeat',
                        textStyle: TextStyle(
                            letterSpacing: 3,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                    isRepeatingAnimation: true,
                    totalRepeatCount: 100,
                    pause: Duration(milliseconds: 1000),
                  ),
                ],
              ),
            ),
          ),
        ),
        drawer: MyDrawer(),
      ),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool? exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Really ??"),
            content: const Text("Do you want to exit the app ?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text("No"),
              ),
              TextButton(
                onPressed: () {
          // Navigator.of(context)
          //     .pushNamedAndRemoveUntil("/welcome", ModalRoute.withName('/welcome'));
          //     },
          Navigator.of(context).pop(true);
          },
                child: const Text("Yes"),
              ),
            ],
          );
        });
    return exitApp ?? false;
  }
}
