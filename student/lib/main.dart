import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/screens/AddStudent.dart';
import 'package:student/screens/EditStudent.dart';
import 'package:student/screens/ViewStudents.dart';
import 'package:student/service/StudentService.dart';

import 'StudentListViewModel.dart';
import 'models/StudentModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StudentListViewModel _viewModel;

  late List<StudentModel> _studentList = <StudentModel>[];
  final _studentService = StudentService();

  getAllStudentInformation() async {
    try{
      var students = await _studentService.readAllStudents();
      _studentList = <StudentModel>[];
      students.forEach((student) {
        setState(() {
          var studentModel = StudentModel();
          studentModel.id = student['id'];
          studentModel.firstName = student['firstName'];
          studentModel.lastName = student['lastName'];
          studentModel.dateOfBirth = student['dateOfBirth'];
          studentModel.gender = student['gender'];
          _studentList.add(studentModel);
        });
      });} catch (error) {
        showFlashError(context, error.toString());
      }
  }

  @override
  void initState() {
    _viewModel = StudentListViewModel();
    _viewModel.getAllStudentInformation();
    super.initState();
  }

  _deleteFormDialog(BuildContext context, studentId){
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
                'Are you sure want to delete?',
              style: TextStyle(color: Colors.blueAccent),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.red,
                    backgroundColor: Colors.black),
                  onPressed: () async {
                    try {
                      await _viewModel.deleteStudent(studentId);
                    } catch (error) {
                      showFlashError(context, error.toString());
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.blue,
                    backgroundColor: Colors.black
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }, child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => _viewModel,
        child: Consumer<StudentListViewModel>(
          builder: (context, viewModel, child) {
            return ListView.builder(
              itemCount: viewModel.studentList.length,
              itemBuilder: (context, index) {
                var student = viewModel.studentList[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewStudents(student: student),
                        ),
                      );
                    },
                    leading: const Icon(Icons.person),
                    title: Text("${student.firstName} ${student.lastName}" ?? ''),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditStudent(student: student),
                              ),
                            ).then((data) async {
                              if (data != null) {
                                await _viewModel.updateStudent(data);
                              }
                            }).catchError((error) {
                              showFlashError(context, error.toString());
                            });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _deleteFormDialog(context, student.id);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddStudent()))
              .then((data) {
            if (data != null) {
              _viewModel.addStudent(data);
            }
          }).catchError((error) {
            showFlashError(context, error.toString());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void showFlashError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
