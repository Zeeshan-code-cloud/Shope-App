import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

import 'Main_page.dart';
import 'SignUp_screen.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emialController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdf9f4),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Image(image: AssetImage("assets/images/ecommerce.png")),
            ),
            const SizedBox(
              height: 52.0,
            ),
            Form(
                child: Column(
                  children: [
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.98,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(offset: Offset(0, 2), color: Colors.grey)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          controller: emialController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email_outlined)),
                          onChanged: ((value) => {"enter email"}),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.98,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(offset: Offset(0, 2), color: Colors.grey)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Password",
                              prefixIcon: Icon(Icons.lock_outline)),
                          onChanged: ((value) => {"enter password"}),
                        ),
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 40,
            ),
            InkWell(
                onTap: () async {
                  var email = emialController.text.trim();
                  var password = passwordController.text.trim();
                  if (email.isEmpty || password.isEmpty) {
                    Fluttertoast.showToast(msg: "Please fill all field");
                    return;
                  }
                  ProgressDialog progressDialog = ProgressDialog(context,
                      title: const Text("Signing In"),
                      message: const Text("Please Wait"));
                  progressDialog.show();
                  try {
                    UserCredential userCredential =
                    await auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (userCredential.user != null) {
                      progressDialog.dismiss();

                      Fluttertoast.showToast(msg: "operation done");
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MainPage()));
                      return;
                    }
                  } on FirebaseAuthException catch (e) {
                    progressDialog.dismiss();
                    if (e.code == "user-not-found") {
                      Fluttertoast.showToast(msg: "user not found");
                      return;
                    } else if (e.code == "wrong-password") {
                      Fluttertoast.showToast(msg: "wrong password");
                      return;
                    }
                  } catch (e) {
                    progressDialog.dismiss();
                    Fluttertoast.showToast(msg: "Something went wrong");
                    return;
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
                        "Login",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ))),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23),
              child: Row(
                children: [
                  const Text(
                    "Don't have an account",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const SignUp()));
                      },
                      child: const Text(
                        "Creat Account",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ))
                ],
              ),
            )
          ]),
    );
  }
}
