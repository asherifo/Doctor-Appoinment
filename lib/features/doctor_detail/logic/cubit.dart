import 'package:dio/dio.dart';
import 'package:doctor_appoinment/features/doctor_detail/logic/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/const/api_const.dart';
import '../../../core/helper/cash_helper.dart';
import '../../../core/helper/dio_helper.dart';
import '../../alldoctors/data/all_doctor_model.dart';

class DoctorsCubit extends Cubit<DoctorDetailState> {
  // 💡 التعديل هنا: نجعل الحالة الابتدائية هي SuccessState مباشرة 
  // لكي يستقبل الـ UI قيم التاريخ والوقت فوراً وتعمل ميثودز التغيير بسلاسة
  DoctorsCubit() : super(DoctorDetailSuccessState(
    selectedDate: DateTime.now(),
    selectedTime: "10:30 AM", allDoctorModel: AllDoctorModel(),
  ));

  final Dio dio = Dio();

  // يمكنك الإبقاء على هذه الدالة أو حذفها إذا كنت لا تستخدمها نهائياً في هذه الصفحة
  Future<void> getDoctor() async {
    emit(DoctorDetailLoadingState());

    try {
      final token = await SecureStorageHelper.getToken();
      final response = await dio.get(
        ApiConst.allDoctors,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.statusCode == 200) {
        final result = AllDoctorModel.fromJson(response.data);

        emit(DoctorDetailSuccessState(
          allDoctorModel: result,
          selectedDate: DateTime.now(),
          selectedTime: "10:30 AM",
        ));
      }
    } on DioException catch (e) {
      emit(DoctorDetailErrorState(
        errorMsg: DioExceptionHelper.fromDioException(e),
      ));
    }
  }

  // وظيفة لتغيير التاريخ المحدد في واجهة المستخدم
  void changeSelectedDate(DateTime newDate) {
    if (state is DoctorDetailSuccessState) {
      final currentState = state as DoctorDetailSuccessState;
      emit(currentState.copyWith(selectedDate: newDate));
    }
  }

  // وظيفة لتغيير الوقت المحدد (الآن ستعمل وتغير اللون للأزرق فوراً)
  void changeSelectedTime(String newTime) {
    if (state is DoctorDetailSuccessState) {
      final currentState = state as DoctorDetailSuccessState;
      emit(currentState.copyWith(selectedTime: newTime));
    }
  }
}