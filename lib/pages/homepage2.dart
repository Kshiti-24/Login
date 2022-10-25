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
            SizedBox(height: 30,),
            Text("Welcome",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20,),
            Text("Email :",),
            SizedBox(height: 11,),
            Text(
              user.email!,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20,),
            Text(
              "User Id"
            ),
            SizedBox(height: 11,),
            Text(
              user.uid,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 30,),
            Text("Check Drawer",
              style: const TextStyle(
                color: Colors.indigo,
                  fontSize: 30,
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