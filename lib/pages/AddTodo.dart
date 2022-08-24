// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todoproject/pages/HomePage.dart';

import '../Service/Auth_service.dart';

class Addtodo extends StatefulWidget {
  const Addtodo({Key? key}) : super(key: key);

  @override
  State<Addtodo> createState() => _AddtodoState();
}

class _AddtodoState extends State<Addtodo> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  AuthClass authClass = AuthClass();

// set the state for type and category
  String type = "";
  String category = "";
  String uid = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 33, 36, 47),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_left,
                color: Colors.white,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Create",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4)),
                  SizedBox(
                    height: 8,
                  ),
                  Text("New TODO",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2)),
                  SizedBox(
                    height: 20,
                  ),
                  label("Task Title"),
                  SizedBox(
                    height: 20,
                  ),
                  title(),
                  SizedBox(
                    height: 20,
                  ),
                  label("Task Type"),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Categoryselected("important", 0xff2664fa),
                      SizedBox(
                        width: 20,
                      ),
                      Categoryselected("casual", 0xff2bc8d9),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  label("Description"),
                  SizedBox(
                    height: 20,
                  ),
                  description(),
                  SizedBox(
                    height: 20,
                  ),
                  label("Category"),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    runSpacing: 10,
                    children: [
                      taskselected("Food", 0xffff6d6e),
                      SizedBox(
                        width: 20,
                      ),
                      taskselected("work", 0xfff29732),
                      SizedBox(
                        width: 20,
                      ),
                      taskselected("workOut", 0xff6557ff),
                      SizedBox(
                        width: 20,
                      ),
                      taskselected("Hangout", 0xff234ebd),
                      SizedBox(
                        width: 20,
                      ),
                      taskselected("Run", 0xff2bc8d9),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  button(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget button() {
    return InkWell(
      // add todo to database

      onTap: () async {
        final uid = authClass.getCurrentUID();
        FirebaseFirestore.instance
            .collection("UserData")
            .doc(uid)
            .collection("Todo")
            .add({
          "title": _titleController.text,
          "description": _descriptionController.text,
          "task": type,
          "category": category,
        });

        Navigator.pop(context);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 38, 173, 72),
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 31, 73, 116),
              Color.fromARGB(255, 22, 200, 185),
            ],
          ),
        ),
        child: Center(
          child: Text(
            "Add Todo",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
        ),
      ),
    );
  }

  Widget title() {
    // ignore: dead_code
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 50, 49, 49),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color.fromARGB(255, 95, 225, 239), width: 1),
      ),
      child: TextFormField(
        // push to firebase and add todo to database
        controller: _titleController,
        style:
            TextStyle(color: Color.fromARGB(255, 255, 252, 252), fontSize: 17),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
        ),
      ),
    );
  }

  Widget description() {
    // ignore: dead_code
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 52, 52, 52),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color.fromARGB(255, 95, 225, 239), width: 1),
      ),
      child: TextFormField(
        // push to firebase and add todo to database
        controller: _descriptionController,
        style:
            TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 17),
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
        ),
      ),
    );
  }

  Widget taskselected(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          type = label;
        });
      },
      child: Chip(
        backgroundColor: type == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          label,
          style: TextStyle(
              color: type == label ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget Categoryselected(String label, int color) {
    return InkWell(
      onTap: () {
        setState(() {
          category = label;
        });
      },
      child: Chip(
        backgroundColor: category == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        label: Text(
          label,
          style: TextStyle(
              color: category == label ? Colors.black : Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.2,
      ),
    );
  }
}
