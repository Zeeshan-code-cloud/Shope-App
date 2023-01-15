import 'package:flutter/material.dart';
import 'SignIn_screen.dart';
import 'SignUp_screen.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 130,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Tussy Shope",
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                    image:
                    DecorationImage(image: AssetImage("assets/images/ecommerce.png"))),
              ),
              const SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: Container(
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
                  child: const Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(fontSize: 18, fontFamily: "roboto"),
                      )),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
                child: Container(
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
                  child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 18, fontFamily: "roboto"),
                      )),
                ),
              )
            ],
          )),
    );
  }
}
