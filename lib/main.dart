import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/pages/homePage.dart';
import 'package:login_ui/pages/homepage2.dart';
import 'package:login_ui/pages/loginPage.dart';
import 'package:login_ui/pages/newloginPage.dart';
import 'package:login_ui/pages/otp.dart';
import 'package:login_ui/pages/verify.dart';
import 'package:login_ui/pages/welcomePage.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:login_ui/widgets/themes.dart';
import 'package:login_ui/pages/signin_page.dart';
import 'package:login_ui/pages/passwordPage.dart';
import 'package:login_ui/pages/homepage2.dart';
import 'package:login_ui/pages/verify.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int num=1;
    String name="Kshitiz Agarwal";
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      themeMode: ThemeMode.light,
      theme:MyTheme.lightTheme(context),
      darkTheme:MyTheme.darkTheme(context),
      initialRoute: "/",
      routes: {
        "/": (context) => WelcomePage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.signInRoute: (context) => SignInPage(),
        MyRoutes.passwordRoute: (context) => PasswordPage(),
        MyRoutes.verifyRoute: (context) => VerifyPage(),
        MyRoutes.newHomeRoute: (context) => NewHomePage(),
        MyRoutes.otpRoute: (context) => OtpPage(),
        MyRoutes.newloginRoute: (context) => NewLoginPage(),
      },
    );
  }
}

