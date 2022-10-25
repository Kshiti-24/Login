import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/utils/routes.dart';
import 'package:login_ui/widgets/drawer.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
          title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          TextButton.icon(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, MyRoutes.loginRoute);
          },
              icon: Icon(Icons.logout),
              label: Text('Log Out'),
            style: TextButton.styleFrom(),
          ),
        ],
      ),

      body:Center(
        child:Column(
          children: [
            Text("Welcome\nSigned in as:"),
            SizedBox(height: 8),
            Text(
              user.email!,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}