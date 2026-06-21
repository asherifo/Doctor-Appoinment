class LoginModel {
  final String email;
  final String password;

  LoginModel({
    required this.email,
    required this.password,
  });

  // تحويل الكائن إلى Map لإرساله كـ JSON أو Form-data
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}