import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fullfirebase/pages/home.dart';
import 'package:fullfirebase/pages/signup.dart';
import 'package:fullfirebase/uihelper/uihelper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String emailMain = "";
  String passMain = "";

  moveToHome(BuildContext context) async {
    if(_formKey.currentState!.validate()){
      UserCredential? userCreds;
      try{
        userCreds=await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailMain, password: passMain).then((value){
          Navigator.pushReplacement(context as BuildContext,
              MaterialPageRoute(builder: (context) => HomePage()));
        });
      }
      on FirebaseAuthException catch(ex){
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                icon: const Icon(Icons.error),
                title: Text(ex.code.toString()),
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              //Email Controller
              TextFormField(
                controller: emailController,
                obscureText: false,
                decoration: InputDecoration(
                    hintText: "Enter Your Email",
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Email cannot be null");
                  } else {
                    emailMain = value;
                  }
                  return null;
                },
              ),


              SizedBox(
                height: 10,
              ),


              //Pass Controller
              TextFormField(
                controller: passController,
                obscureText: false,
                decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    labelText: "Password",
                    prefixIcon: Icon(Icons.password),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return ("Password cannot be null");
                  } else if (value.length < 6) {
                    return ("Password should at least be 6 characters");
                  } else {
                    passMain = value;
                  }
                  return null;
                },
              ),


              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                child: const Text("Login"),
                onPressed: () => moveToHome(context),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(150, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an Account?",style: TextStyle(fontSize: 16),),
                  TextButton(onPressed: (){ 
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> SignUpPage()), (route) => false);
                  }, child: Text("Sign Up",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
