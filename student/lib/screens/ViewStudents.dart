import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/StudentModel.dart';

class ViewStudents extends StatefulWidget{
  final StudentModel student;
  
  const ViewStudents({super.key, required this.student});
  
  @override
  State<ViewStudents> createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Student complete information",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey,
                fontSize: 20),
              ),
            const SizedBox(
              height: 20,
            ),
            Row (
              children: [
                const Text('First name',
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
                Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(widget.student.firstName ?? '',
                            style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row (
              children: [
                const Text('Last name',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(widget.student.lastName ?? '',
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row (
              children: [
                const Text('Date of birth',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(widget.student.dateOfBirth ?? '',
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row (
              children: [
                const Text('Gender',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(widget.student.gender ?? '',
                      style: TextStyle(fontSize: 16)),
                ),
              ],
            )
          ],
        ),
      ));
  }
  
}