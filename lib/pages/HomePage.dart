// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, sort_child_properties_last, non_constant_identifier_names, prefer_if_null_operators, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoproject/pages/AddTodo.dart';
import 'package:todoproject/pages/TodoCard.dart';
import 'package:todoproject/pages/viewdata.dart';
import '../Service/Auth_service.dart';
import 'SigninPage.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  AuthClass authClass = AuthClass();
  List<select> selected = [];

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final uid = authClass.getCurrentUID();

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text(
            "Today's ToDo",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ), // Textstyle
          ), // Text

          bottom: PreferredSize(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedDate.year.toString() +
                            "/" +
                            selectedDate.month.toString() +
                            "/" +
                            selectedDate.day.toString(),
                        style: TextStyle(
                          fontSize: 37,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // delete the task

                              var instance = FirebaseFirestore.instance
                                  .collection("UserData")
                                  .doc(uid)
                                  .collection("Todo");
                              instance.doc(selected[0].id).delete();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              // logout
                              await authClass.logout();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => SigninPage()),
                                  (route) => false);
                            },
                            icon: Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(35)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.white, size: 30),
                label: ''),
            BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) => (Addtodo())));
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.blue,
                    size: 50,
                  ),
                ),
                label: ''),
          ],
          onTap: (int index) {
            print(index);
          },
        ),
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // dynamic card for todo

              StreamBuilder<Object>(
                  stream: FirebaseFirestore.instance
                      .collection("UserData")
                      .doc(uid)
                      .collection("Todo")
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            IconData icondata;
                            Color iconcolor;
                            Map<String, dynamic> document =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            switch (document["category"]) {
                              case "work":
                                icondata = Icons.run_circle_outlined;
                                iconcolor = Colors.red;
                                break;
                              case "Food":
                                icondata = Icons.fastfood;
                                iconcolor = Colors.orange;
                                break;
                              case "workOut":
                                icondata = Icons.alarm_on;
                                iconcolor = Colors.green;
                                break;
                              case "Hangout":
                                icondata = Icons.local_play;
                                iconcolor = Colors.blue;
                                break;
                              case "Run":
                                icondata = Icons.directions_run;
                                iconcolor = Colors.green;
                                break;
                              default:
                                icondata = Icons.run_circle_outlined;
                                iconcolor = Colors.red;
                                break;
                            }
                            selected.add(select(
                                id: snapshot.data!.docs[index].id,
                                checkvalue: false));
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (builder) => (viewdata(
                                              document: document,
                                              id: snapshot.data!.docs[index].id,
                                            ))));
                              },
                              child: TodoCard(
                                title: document['title'] == null
                                    ? ''
                                    : document['title'],
                                color: iconcolor,
                                time: '1 pm',
                                check: selected[index].checkvalue,
                                iconbgcolor: Colors.white,
                                iconData: icondata,
                                index: index,
                                onChange: onChange,
                              ),
                            );
                          });
                    }
                  }),
            ],
          ),
        )));
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkvalue = !selected[index].checkvalue;
    });
  }
}

class select {
  late String id;
  bool checkvalue = false;
  select({required this.id, required this.checkvalue});
}


// IconButton(
//           icon: Icon(Icons.logout),
//           onPressed: () async {
//             await authClass.logout();
//             Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(builder: (builder) => SignUpPage()),
//                 (route) => false);
//           },
//         )
