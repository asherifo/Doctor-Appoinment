class AuthResponseModel {
  final String message;
  final UserData? data;
  final bool status;
  final int code;

  AuthResponseModel({
    required this.message,
    this.data,
    required this.status,
    required this.code,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      message: json['message'] ?? '',
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
      status: json['status'] ?? false,
      code: json['code'] ?? 0,
    );
  }
}

class UserData {
  final String token;
  final String username;

  UserData({
    required this.token,
    required this.username,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      token: json['token'] ?? '',
      username: json['username'] ?? '',
    );
  }
}