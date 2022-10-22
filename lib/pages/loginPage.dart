import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_ui/utils/routes.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70,),
              Image.asset('assets/images/sign.png'),
              SizedBox(height: 10,),
              Text('My First App',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 400,
                width: 325,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    Text('Greetings',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                SizedBox(height: 10,),
                Text('Enter your details to login',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black26
                ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: 250,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      suffixIcon: Icon(Icons.email,color: Colors.black,size: 17,
                    ),
                      hintText: 'Enter your email',
                  ),
                )
                ),
                Container(
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: Icon(Icons.lock,color: Colors.black,size: 17,
                        ),
                        hintText: 'Enter your email',
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 40, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forget Password',
                      style: TextStyle(
                        color: Colors.deepPurple
                      ),
                      )
                    ],
                  ),
                )
              ],
                  ),
          ),
          ],
        ),
      ),
    ),
    );
  }
}
