import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../database/databaseConnection.dart';
import '../models/StudentModel.dart';
import '../service/StudentService.dart';
import 'package:intl/intl.dart';

class EditStudent extends StatefulWidget{
  final StudentModel student;
  const EditStudent({super.key, required this.student});

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  final _studentFirstNameController = TextEditingController();
  final _studentLastNameController = TextEditingController();
  final _studentDateOfBirthController = TextEditingController();
  final _studentGenderController = TextEditingController();
  bool _validateFirstName = false;
  bool _validateLastName = false;
  bool _validateDateOfBirth = false;
  bool _validateGender = false;
  var studentService = StudentService();

  @override
  void initState() {
      _studentFirstNameController.text = widget.student.firstName??'';
      _studentLastNameController.text = widget.student.lastName??'';
      _studentDateOfBirthController.text = widget.student.dateOfBirth??'';
      _studentGenderController.text = widget.student.gender??'';
    super.initState();
  }

  @override
  void dispose() {
    _studentFirstNameController.dispose();
    _studentLastNameController.dispose();
    _studentDateOfBirthController.dispose();
    _studentGenderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit user"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              const SizedBox(
                height: 20,
              ),
              TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z ]{1,30}$"))
                  ],
                  controller: _studentFirstNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "First name",
                    labelText: "First Name",
                    errorText:
                    _validateFirstName ? "First name can not be empty!" : null,
                  )),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z]{1,30}$"))
                  ],
                  controller: _studentLastNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Last name",
                    labelText: "Last Name",
                    errorText:
                    _validateLastName ? "Last name can not be empty!" : null,
                  )),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _studentDateOfBirthController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: "Date of birth",
                    hintText: "Date of birth",
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2024)
                    );

                    if(pickedDate != null ){
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      setState(() {
                        _studentDateOfBirthController.text = formattedDate;
                        _validateDateOfBirth = false;
                      });
                    } else {
                      setState(() {
                        _validateDateOfBirth = true;
                      });
                    }
                  },

              ),
              if (_validateDateOfBirth)
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    "   Date of birth can not be empty",
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r"^[a-zA-Z ]{1,30}$"))
                  ],
                  controller: _studentGenderController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Gender",
                    labelText: "Gender",
                    errorText:
                    _validateGender ? "Gender can not be empty!" : null,
                  )),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.blueAccent, backgroundColor: Colors.black,
                      textStyle: const TextStyle(fontSize: 15, color: Colors.white)),
                  onPressed: () async {
                    setState(() {
                      _studentFirstNameController.text.isEmpty
                          ? _validateFirstName = true
                          : _validateFirstName = false;
                      _studentLastNameController.text.isEmpty
                          ? _validateLastName = true
                          : _validateLastName = false;
                      _studentDateOfBirthController.text.isEmpty
                          ? _validateDateOfBirth = true
                          : _validateDateOfBirth = false;
                      _studentGenderController.text.isEmpty
                          ? _validateGender = true
                          : _validateGender = false;
                    });

                    if (_validateFirstName == false &&
                        _validateLastName == false &&
                        _validateDateOfBirth == false &&
                        _validateGender == false){
                      var student = StudentModel();
                      student.id = widget.student.id;
                      student.firstName = _studentFirstNameController.text;
                      student.lastName = _studentLastNameController.text;
                      student.dateOfBirth = _studentDateOfBirthController.text;
                      student.gender = _studentGenderController.text;
                      // var result = await studentService.updateStudent(student);
                      Navigator.pop(context, student);
                    }
                  },
                  child: const Text("Save student")),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.blueAccent, backgroundColor: Colors.black,
                      textStyle: const TextStyle(fontSize: 15, color: Colors.white)),
                  onPressed: () {
                    _studentFirstNameController.text = '';
                    _studentLastNameController.text = '';
                    _studentDateOfBirthController.text = '';
                    _studentGenderController.text = '';
                  },
                  child: const Text('Clear fields'),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}