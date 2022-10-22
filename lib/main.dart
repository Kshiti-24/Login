import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/pages/loginPage.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:login_ui/widgets/themes.dart';

void main() {
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
        "/": (context) => LoginPage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
      },
    );
  }
}

