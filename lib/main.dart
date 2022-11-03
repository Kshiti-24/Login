import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/pages/homePage.dart';
import 'package:login_ui/pages/homepage2.dart';
import 'package:login_ui/pages/loginPage.dart';
import 'package:login_ui/pages/loginPage2.dart';
import 'package:login_ui/pages/newloginPage.dart';
import 'package:login_ui/pages/otp.dart';
import 'package:login_ui/pages/verify.dart';
import 'package:login_ui/pages/welcomePage.dart';
import 'package:login_ui/services/auth._service.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:login_ui/widgets/drawer.dart';
import 'package:login_ui/widgets/themes.dart';
import 'package:login_ui/pages/signin_page.dart';
import 'package:login_ui/pages/passwordPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      home: StreamBuilder(
          stream: AuthService().firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return NewHomePage();
            } else {
              return WelcomePage();
            }
          }),
      routes: {
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.signInRoute: (context) => SignInPage(),
        MyRoutes.passwordRoute: (context) => PasswordPage(),
        MyRoutes.verifyRoute: (context) => VerifyPage(),
        MyRoutes.newHomeRoute: (context) => NewHomePage(),
        MyRoutes.otpRoute: (context) => OtpPage(),
        MyRoutes.newloginRoute: (context) => NewLoginPage(),
        MyRoutes.addloginRoute: (context) => AddLoginPage(),
        MyRoutes.welcomeRoute: (context) => WelcomePage(),
        MyRoutes.drawerRoute: (context) => MyDrawer(),
      },
    );
  }
}

class InitializerWidget extends StatefulWidget {
  const InitializerWidget({Key? key}) : super(key: key);

  @override
  State<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  late FirebaseAuth _auth;

  late User _user;

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser!;
    bool isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _user == null
            ? NewLoginPage()
            : NewHomePage();
  }
}
