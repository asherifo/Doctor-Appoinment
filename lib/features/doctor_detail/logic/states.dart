import 'package:doctor_appoinment/features/alldoctors/data/all_doctor_model.dart';

abstract class DoctorDetailState {}

class DoctorDetailInialState extends DoctorDetailState {}

class DoctorDetailLoadingState extends DoctorDetailState {}

class DoctorDetailSuccessState extends DoctorDetailState {
  final AllDoctorModel allDoctorModel;
  final DateTime selectedDate;
  final String selectedTime;

  DoctorDetailSuccessState({
    required this.allDoctorModel,
    required this.selectedDate,
    required this.selectedTime,
  });

  // ميثود مساعدة لتحديث التاريخ أو الوقت مع الحفاظ على الموديل الحالي للأطباء
  DoctorDetailSuccessState copyWith({
    AllDoctorModel? allDoctorModel,
    DateTime? selectedDate,
    String? selectedTime,
  }) {
    return DoctorDetailSuccessState(
      allDoctorModel: allDoctorModel ?? this.allDoctorModel,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedTime: selectedTime ?? this.selectedTime,
    );
  }
}

class DoctorDetailErrorState extends DoctorDetailState {
  final String errorMsg;
  DoctorDetailErrorState({required this.errorMsg});
}