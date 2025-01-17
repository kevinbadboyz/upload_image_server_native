import 'dart:io';

class UserParam {
  final int? id;
  final String firstName;
  final String lastName;
  final String gender;
  final File? image;

  UserParam(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.image});
}
