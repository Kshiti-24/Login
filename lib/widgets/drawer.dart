import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    bool check=false;
    final imageUrl =
        "https://media-exp1.licdn.com/dms/image/C4E03AQEUzuySJWLvrw/profile-displayphoto-shrink_800_800/0/1638700706814?e=2147483647&v=beta&t=4fS_HTAIS_d_42UYO2uyPb2togSOr_utvXa8bJUf1N0";
    return Drawer(
      child: Container(
        color: Colors.teal,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                accountName: Text(
                 user.displayName ?? "Hello ",
                  style: TextStyle(color: Colors.white),
                ),
                accountEmail: Text(
                  user.email ??  "" ,
                  style: TextStyle(color: Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL ?? 'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                ),

              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.home,
                color: Colors.white,
              ),
              title: Text(
                "Home",
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, MyRoutes.homeRoute);
              },
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
              title: Text(
                "Profile",
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.mail,
                color: Colors.white,
              ),
              title: Text(
                "Email Me",
                textScaleFactor: 1.2,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
