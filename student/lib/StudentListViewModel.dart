import 'package:flutter/cupertino.dart';
import 'package:student/service/StudentService.dart';

import 'models/StudentModel.dart';

class StudentListViewModel extends ChangeNotifier {
  late List<StudentModel> _studentList = <StudentModel>[];
  final StudentService _studentService = StudentService();

  List<StudentModel> get studentList => _studentList;

  Future<void> getAllStudentInformation() async {
      var students = await _studentService.readAllStudents();
      _studentList = <StudentModel>[];
      students.forEach((student) {
        var studentModel = StudentModel();
        studentModel.id = student['id'];
        studentModel.firstName = student['firstName'];
        studentModel.lastName = student['lastName'];
        studentModel.dateOfBirth = student['dateOfBirth'];
        studentModel.gender = student['gender'];
        _studentList.add(studentModel);
      });
    notifyListeners();
  }

  Future<void> updateStudent(StudentModel student) async {
    var result = await _studentService.updateStudent(student);
    if (result != null) {
      _studentList[_studentList.indexWhere((element) => element.id == student.id)] = student;
      notifyListeners();
    }
  }

  Future<void> addStudent(StudentModel student) async {
    var result = await _studentService.saveStudent(student);
    if (result != null) {
      _studentList.add(student);
      notifyListeners();
    }
  }

  Future<void> deleteStudent(int studentId) async {
    var result = await _studentService.deleteStudent(studentId);
    if (result != null) {
      _studentList.removeWhere((student) => student.id == studentId);
      notifyListeners();
    }
  }
}