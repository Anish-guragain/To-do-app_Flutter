// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../Service/Auth_service.dart';
import 'SignUpPage.dart';
import 'home.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool circularProgress = false;
  AuthClass authClass = AuthClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              buttonitem('assets/google.svg', "continue with Google", 25, () {
                authClass.googleSignIn(context);
              }),
              SizedBox(
                height: 15,
              ),
              buttonitem('assets/phone.svg', "continue with Phone", 25, () {}),
              SizedBox(
                height: 15,
              ),
              Text(
                'OR',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              textitem('Email', _emailController),
              SizedBox(
                height: 15,
              ),
              textitem('Password', _passwordController),
              SizedBox(
                height: 15,
              ),
              Text(
                'Forget password?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              button(),
              SizedBox(
                height: 15,
              ),
              // already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dont have an account?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUpPage()));
                    },
                    child: Text(
                      'SignUp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )));
  }

  Widget button() {
    return InkWell(
      onTap: () async {
        setState(() {
          circularProgress = true;
        });
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text);
          setState(() {
            circularProgress = false;
          });
          // ignore: use_build_context_synchronously
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => home()),
              (route) => false);
        } catch (e) {
          final snackBar = SnackBar(
            content: Text(e.toString()),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          setState(() {
            circularProgress = false;
          });
        }
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget buttonitem(
      String imagepath, String buttonNamae, double size, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.white, width: 2)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagepath,
                height: size,
                width: size,
              ),
              SizedBox(width: 50),
              Text(
                buttonNamae,
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textitem(String text, TextEditingController controller) {
    return Container(
        width: MediaQuery.of(context).size.width - 70,
        height: 60,
        child: TextFormField(
          controller: controller,
          style: TextStyle(color: Colors.white, fontSize: 17),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            labelText: text,
            labelStyle: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ));
  }
}
