// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.title,
    required this.iconData,
    required this.color,
    required this.time,
    required this.check,
    required this.iconbgcolor,
    required this.onChange,
    required this.index,
  }) : super(key: key);

  final String title;
  final IconData iconData;
  final Color color;
  final String time;
  final bool check;
  final Color iconbgcolor;
  final Function onChange;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Theme(
              data: ThemeData(
                  primarySwatch: Colors.blue,
                  unselectedWidgetColor: Color(0xff5e616a)),
              child: Transform.scale(
                scale: 1.5,
                // checkbox for the todo app
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  activeColor: Color(0xff6cf8a9),
                  checkColor: Color(0xff0e3e26),
                  value: check,
                  onChanged: (bool? change) {
                    onChange(index);
                  },
                ),
              ),
            ),
            Expanded(
                child: Container(
                    height: 75,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Color(0xff2a2e3d),
                      child: Row(children: [
                        SizedBox(width: 15),
                        Container(
                          height: 33,
                          width: 33,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: iconbgcolor),
                          child: Icon(
                            // icons picture of the todo
                            iconData,
                            color: color,
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            // Title of the Todo
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          // Time added
                          time,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 15),
                      ]),
                    )))
          ],
        ));
  }
}
