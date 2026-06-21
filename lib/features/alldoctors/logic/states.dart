import 'package:doctor_appoinment/features/alldoctors/data/search_doctor_model.dart';

abstract class AllDoctorsState {}

class AllDoctorInitialState extends AllDoctorsState {}
class AllDoctorLoadingState extends AllDoctorsState {}

class AllDoctorSuccessState extends AllDoctorsState {
  final List<DoctorModel> doctors; // 🎯 القائمة الموحدة النضيفة
  AllDoctorSuccessState({required this.doctors});
}

class AllDoctorErrorState extends AllDoctorsState {
  final String errorMsg;
  AllDoctorErrorState({required this.errorMsg});
}