import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fullfirebase/pages/login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final ageController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String emailMain = "";
  String passMain = "";
  String fName = "";
  String lName = "";
  int age = 0;

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {

      //Create User
      try {
        UserCredential? userCredential;
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailMain, password: passMain)
            .then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
          return showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  icon: Icon(Icons.done_outline_rounded),
                  title: Text("Account Created"),
                );
              });
        });


        //Add User Details
        addUserDetails();


      } on FirebaseAuthException catch (ex) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                icon: const Icon(Icons.error),
                title: const Text("Error"),
                content: Text(ex.code.toString()),
              );
            });
      }
    }
  }

  Future addUserDetails()async{
  await FirebaseFirestore.instance.collection('users').add({
  'first name': fName,
  'last name': lName,
  'email': emailMain,
  'age': age,
  });
}

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    fNameController.dispose();
    lNameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Page"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
              
                  //FName Controller
                  TextFormField(
                    controller: fNameController,
                    obscureText: false,
                    decoration: InputDecoration(
                        hintText: "Enter Your First Name",
                        labelText: "First Name",
                        prefixIcon: const Icon(Icons.account_box_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("First Name cannot be null");
                      } else {
                        fName = value;
                      }
                      return null;
                    },
                  ),
              
                  const SizedBox(
                    height: 10,
                  ),
              
                  //LName Controller
                  TextFormField(
                    controller: lNameController,
                    obscureText: false,
                    decoration: InputDecoration(
                        hintText: "Enter Your Last Name",
                        labelText: "Last Name",
                        prefixIcon: const Icon(Icons.account_box_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Last Name cannot be null");
                      } else {
                        lName = value;
                      }
                      return null;
                    },
                  ),
              
                  const SizedBox(
                    height: 10,
                  ),
              
              
                  //Age Controller
                  TextFormField(
                    controller: ageController,
                    obscureText: false,
                    decoration: InputDecoration(
                        hintText: "Enter Your Age",
                        labelText: "Age",
                        prefixIcon: const Icon(Icons.accessibility_new_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Age cannot be null");
                      } else {
                        age = int.parse(value.toString());
                      }
                      return null;
                    },
                  ),


                  const SizedBox(
                    height: 10,
                  ),
              
                  // Email Controller
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Email cannot be null");
                      } else {
                        emailMain = value;
                      }
                      return null;
                    },
                  ),
              
                  const SizedBox(
                    height: 10,
                  ),
              
                  //Password Controller
                  TextFormField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Enter Your Password",
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.password),
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
              
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      moveToHome(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(150, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        textStyle:
                            const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    child: const Text("SignUp"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an Account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                                (route) => false);
                          },
                          child: const Text(
                            "Log In",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
      ),
    );
  }
}
