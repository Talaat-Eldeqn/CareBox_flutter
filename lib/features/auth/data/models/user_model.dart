class UserModel {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? token;

  UserModel({this.id, this.name, this.email, this.phoneNumber, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int
          ? json['id']
          : (json['id'] != null ? int.tryParse('${json['id']}') : null),
      name: json['name'] ?? json['fullName'] ?? json['username'],
      email: json['email'],
      phoneNumber: json['phoneNumber'] ?? json['phone'],
      token: json['token'] ?? json['accessToken'] ?? json['authToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'token': token,
    };
  }
}
