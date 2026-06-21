class ApiConst {
  static const String baseUrl = "https://vcare.integration25.com/api";
  static const String register = "${baseUrl}/auth/register";
  static const String login = "${baseUrl}/auth/login" ;
  static const String allDoctors = "${baseUrl}/doctor/index" ;
  static const String searchDoctors = "${baseUrl}/doctor/doctor-search?name=" ;
}