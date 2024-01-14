import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  final emailController = TextEditingController();


  resetPassword() async {
    try{
      String email = emailController.text.toString();
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value){
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Icons.done_outline_rounded),
            title: const Text("Done"),
            content: Text("Reset Password Link has been Sent to your Email"),
        );
      });
    });
    }
    on FirebaseAuthException catch(ex){
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(Icons.error),
            title: const Text("Error"),
            content: Text(ex.code.toString()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              obscureText: false,
              decoration: InputDecoration(
                  hintText: "Enter Your Email",
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () => resetPassword(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(150, 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              child: const Text("Reset"),
            ),
          ],
        ),
      ),
    );
  }
}
