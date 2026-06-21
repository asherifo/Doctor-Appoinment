import 'package:dio/dio.dart';
import 'package:doctor_appoinment/features/alldoctors/data/search_doctor_model.dart';

import '../../../core/const/api_const.dart';
import '../../../core/helper/cash_helper.dart';

class DoctorRepository {
  final Dio dio = Dio();

  // جلب الكل
  Future<DoctorResponse> getAllDoctors() async {
    final token = await SecureStorageHelper.getToken();
    final response = await dio.get(
      ApiConst.allDoctors,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return DoctorResponse.fromJson(response.data);
  }

  // البحث
  Future<DoctorResponse> fetchDoctors(String query) async {
    final token = await SecureStorageHelper.getToken();
    final response = await dio.get(
      "${ApiConst.searchDoctors}$query",
      queryParameters: {'name': query},
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
    return DoctorResponse.fromJson(response.data);
  }
}