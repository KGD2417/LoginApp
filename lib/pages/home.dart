import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fullfirebase/pages/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("HomePage"),
        centerTitle: true,
      ),
      body:
      Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Signed In as: " +user!.email!),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginPage()));
          },child: Text("Sign Out"),)
        ],
      )),
    );
  }
}
