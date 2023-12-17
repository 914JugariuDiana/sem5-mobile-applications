class StudentModel {
  int? id;
  String? firstName;
  String? lastName;
  String? dateOfBirth;
  String? gender;

  Map<String, dynamic> toMap(){
    return <String, dynamic> {
      'id' : id,
      'firstName' : firstName,
      'lastName' : lastName,
      'dateOfBirth' : dateOfBirth,
      'gender' : gender,
    };
  }
}