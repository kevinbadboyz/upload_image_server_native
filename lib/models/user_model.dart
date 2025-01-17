class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String? image;

  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.image});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        gender: json['gender'],
        image: json['image']);
  }
}
