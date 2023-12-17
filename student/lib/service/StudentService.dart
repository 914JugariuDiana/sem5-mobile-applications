import 'dart:ui';

import '../models/StudentModel.dart';
import '../repository/repository.dart';

class StudentService
{
  late Repository _repository;

  StudentService (){
    _repository = Repository();
  }

  saveStudent(StudentModel student) async {
    return await _repository.insertData('student', student.toMap());
  }

  readAllStudents() async {
    return await _repository.readData('student');
  }

  updateStudent(StudentModel student) async {
    var result = await _repository.updateData('student', student.toMap());
    return result;

  }

  deleteStudent(studentId) async {
    return await _repository.deleteDataById('student', studentId);
  }

}