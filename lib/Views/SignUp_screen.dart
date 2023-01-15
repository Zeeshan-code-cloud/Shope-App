import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

import 'SignIn_screen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final Db_ref = FirebaseDatabase.instance.reference().child("User");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 40,
        ),
        Container(
          height: 55,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 240, 251, 231),
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 3,
                    blurStyle: BlurStyle.outer)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(top: 11, left: 12.0),
            child: TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email_rounded),
                  hintText: "email...",
                  border: InputBorder.none),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          height: 55,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 240, 251, 231),
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 3,
                    blurStyle: BlurStyle.outer)
              ]),
          child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 13.0),
              child: TextFormField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline_rounded,
                      color: Color.fromARGB(255, 156, 149, 121),
                    ),
                    hintText: "Password...",
                    border: InputBorder.none),
              )),
        ),
        const SizedBox(
          height: 40,
        ),
        Container(
          height: 55,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 240, 251, 231),
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 3,
                    blurStyle: BlurStyle.outer)
              ]),
          child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 12.0),
              child: TextFormField(
                obscureText: true,
                controller: confirmpasswordController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline_rounded),
                    hintText: "Comfirm Password...",
                    border: InputBorder.none),
              )),
        ),
        const SizedBox(
          height: 40,
        ),
        InkWell(
            onTap: () async {
              var email = emailController.text.trim();
              var password = passwordController.text.trim();
              var confirm_password = confirmpasswordController.text.trim();

              if (email.isEmpty ||
                  password.isEmpty ||
                  confirm_password.isEmpty) {
                Fluttertoast.showToast(msg: "fill all field");
                return;
              } else if (password != confirm_password) {
                Fluttertoast.showToast(msg: "passowrd are not matching");
                return;
              } else if (password.length < 6) {
                Fluttertoast.showToast(msg: "weak passwod");
                return;
              } else {
                ProgressDialog progressDialog = ProgressDialog(context,
                    title: const Text("Sign In"),
                    message: const Text("Please wait"));
                progressDialog.show();

                try {
                  UserCredential userCredential =
                  await auth.createUserWithEmailAndPassword(
                      email: email, password: password);
                  if (userCredential.user != null) {
                    progressDialog.dismiss();

                    String User_id = userCredential.user!.uid;
                    String date =
                    DateTime.now().millisecondsSinceEpoch.toString();
                    Db_ref.child(User_id).set({
                      "Email": email,
                      "UserId": User_id,
                      "Date": date,
                      "password": password,
                    });
                    Fluttertoast.showToast(msg: "operation success");
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SignIn()));
                    return;
                  } else {
                    Fluttertoast.showToast(msg: "operation failed");
                    return;
                  }
                } on FirebaseAuthException catch (e) {
                  progressDialog.dismiss();
                  if (e.code == "email-already-in-use") {
                    Fluttertoast.showToast(msg: "email are already in used");
                    return;
                  } else if (e.code == "invalid-email") {
                    Fluttertoast.showToast(msg: "correct email format");
                    return;
                  } else if (e.code == "operation-not-allowed") {
                    Fluttertoast.showToast(msg: "you are disabled");
                    return;
                  }
                } catch (e) {
                  Fluttertoast.showToast(msg: "Something went wrong");
                  return;
                }
              }
            },
            child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 45, 46, 102),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 3,
                          blurStyle: BlurStyle.outer)
                    ]),
                child: const Center(
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
            )
        ),
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: Row(
            children: [
              const Text(
                "Already have an account",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => SignIn()));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  )
              )
            ],
          ),
        )
      ]
      ),
    );
  }
}
