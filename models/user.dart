class User {
  User(
    this.email,
    this.password,
  );

  factory User.fromJson(Map<String, dynamic> json) {
    // if (json == null) {
    //   throw const FormatException('Null JSON in User constructor');
    // }
    return User(
      json['email'] as String,
      json['password'] as String,
    );
  }
  String? id;
  String email;
  String password;

  Map<String, String> toJson() {
    return {
      'id': id ?? '',
      'email': email,
      'password': password,
    };
  }
}

// mock database
List<User> users = [];
