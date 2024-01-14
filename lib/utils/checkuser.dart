import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fullfirebase/pages/home.dart';
import 'package:fullfirebase/pages/login.dart';

class CheckUser extends StatelessWidget {
  const CheckUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return HomePage();
          }
          else{
            return LoginPage();
          }
        },
      ),
    );
  }

  //Function for Always keeping the user logged in
  // checkUser() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     return HomePage();
  //   } else {
  //     return LoginPage();
  //   }
  // }
}
