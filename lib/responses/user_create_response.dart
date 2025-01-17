class UserCreateResponse {
  final int id;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;

  UserCreateResponse(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.image});
  factory UserCreateResponse.fromJson(Map<String, dynamic> json) {
    return UserCreateResponse(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        gender: json['gender'],
        image: json['image']);
  }
}
