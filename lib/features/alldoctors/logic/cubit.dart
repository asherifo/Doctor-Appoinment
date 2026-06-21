import 'dart:async';

import 'package:dio/dio.dart';
import 'package:doctor_appoinment/features/alldoctors/logic/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/dio_helper.dart';
import '../data/repo.dart';

class AllDoctorsCubit extends Cubit<AllDoctorsState> {
  final DoctorRepository doctorRepository; // استدعينا الـ Repo الموحد
  Timer? _debounce;

  AllDoctorsCubit({required this.doctorRepository}) : super(AllDoctorInitialState());

  // 1. جلب كل الدكاترة
  Future<void> getAllDoctors() async {
    emit(AllDoctorLoadingState());
    try {
      final response = await doctorRepository.getAllDoctors();
      // بنمرر الـ list اللي جوه الـ response
      emit(AllDoctorSuccessState(doctors: response.data));
    } on DioException catch (e) {
      emit(AllDoctorErrorState(errorMsg: DioExceptionHelper.fromDioException(e)));
    } catch (e) {
      emit(AllDoctorErrorState(errorMsg: e.toString()));
    }
  }

  // 2. البحث عن الدكاترة مع الـ Debounce الصحيح
  Future<void> searchDoctors(String query) async {
    // 🛑 خطوة حماية 1: الغي التايمر القديم فوراً لو المستخدم لسه بيكتب
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    if (query.isEmpty) {
      getAllDoctors();
      return;
    }

    // بنعمل الـ الـ Timer هيفضل مستني 500 ملي ثانية بعد آخر حرف يكتبه المستخدم
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(AllDoctorLoadingState()); // شغل التحميل بعد انتهاء الكتابة

      try {
        final response = await doctorRepository.fetchDoctors(query);
        // 🎯 بنبعت نفس الـ Success State ببيانات البحث! الـ UI هيتحدث تلقائياً
        emit(AllDoctorSuccessState(doctors: response.data));
      } catch (error) {
        emit(AllDoctorErrorState(errorMsg: "حدث خطأ أثناء البحث: ${error.toString()}"));
      }
    });
  }

  // 🛑 خطوة حماية 2: لازم تقفل الـ timer لما الـ Cubit يحصل له close عشان ميعملش Memory Leak
  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}