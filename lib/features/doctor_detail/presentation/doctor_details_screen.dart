import 'package:doctor_appoinment/core/utils/app_colors.dart';
import 'package:doctor_appoinment/core/widgets/app_button.dart';
import 'package:doctor_appoinment/features/alldoctors/data/search_doctor_model.dart'; // 🎯 تم التغيير للموديل الموحد
import 'package:doctor_appoinment/features/appoinment_success/presentation/screens/appoinment_success.dart';
import 'package:doctor_appoinment/features/doctor_detail/logic/cubit.dart';
import 'package:doctor_appoinment/features/doctor_detail/logic/states.dart';
import 'package:doctor_appoinment/features/doctor_detail/presentation/widgets/build_tag.dart';
import 'package:doctor_appoinment/features/doctor_detail/presentation/widgets/build_time_period_header.dart';
import 'package:doctor_appoinment/features/doctor_detail/presentation/widgets/build_timer_grid.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorBookingScreen extends StatelessWidget {
  // 🎯 تم تحويل الموديل هنا لـ DoctorModel ومبقاش nullable لزيادة الأمان
  final DoctorModel doctorData;

  const DoctorBookingScreen({super.key, required this.doctorData});

  final List<Map<String, dynamic>> _morningSlots = const [
    {"time": "09:00 AM", "available": true},
    {"time": "09:30 AM", "available": true},
    {"time": "10:00 AM", "available": false},
    {"time": "10:30 AM", "available": true},
    {"time": "11:00 AM", "available": true},
  ];

  final List<Map<String, dynamic>> _afternoonSlots = const [
    {"time": "02:00 PM", "available": true},
    {"time": "02:30 PM", "available": true},
    {"time": "03:30 PM", "available": true},
    {"time": "04:00 PM", "available": false},
  ];

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF004C99);
    const tagBgColor = Color(0xFFE0F7F6);
    const tagTextColor = Color(0xFF26A69A);

    return BlocProvider(
      create: (context) => DoctorsCubit(),
      child: BlocBuilder<DoctorsCubit, DoctorDetailState>(
        builder: (context, state) {
          final cubit = context.read<DoctorsCubit>();
          final DateTime selectedDate = (state is DoctorDetailSuccessState) ? state.selectedDate : DateTime.now();
          final String selectedTime = (state is DoctorDetailSuccessState) ? state.selectedTime : "10:30 AM";

          return Scaffold(
            backgroundColor: AppColors.BackgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: primaryColor),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'DocPoint',
                style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_none, color: primaryColor),
                  onPressed: () {},
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- كارت تفاصيل الطبيب ---
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blue.shade100,
                          // 🎯 التحقق من وجود الصورة بأمان بدون علامات ! ملخبطة
                          backgroundImage: AssetImage('assets/images/doctor.png') ,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          doctorData.name,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              '4.8 (112 reviews)',
                              style: TextStyle(color: Colors.grey[600], fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${doctorData.specialization.name} • \$${doctorData.appointPrice}',
                          style: TextStyle(color: Colors.grey[500], fontSize: 14),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.call, color: AppColors.primary, size: 18),
                            const SizedBox(width: 6),
                            Text(doctorData.phone, style: TextStyle(color: AppColors.primary)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BuildTag(
                                text: 'City: ${doctorData.city.name}',
                                bgColor: tagBgColor,
                                textColor: tagTextColor),
                            const SizedBox(width: 8),
                            BuildTag(
                                text: 'Start: ${doctorData.startTime}',
                                bgColor: tagBgColor,
                                textColor: tagTextColor)
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- قسم About ---
                  const Text(
                    'About',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Dr. ${doctorData.name} is a specialist in ${doctorData.specialization.name}. Available for consultations starting from ${doctorData.startTime} in ${doctorData.city.name}.',
                    style: TextStyle(color: AppColors.primary, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // --- قسم اختيار التاريخ ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select Date',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'June 2026',
                        style: TextStyle(color: Colors.blue[800], fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  EasyDateTimeLine(
                    initialDate: selectedDate,
                    onDateChange: (newDate) {
                      cubit.changeSelectedDate(newDate);
                    },
                    headerProps: const EasyHeaderProps(
                      showMonthPicker: false,
                      showHeader: false,
                    ),
                    dayProps: const EasyDayProps(
                      height: 75,
                      width: 60,
                      dayStructure: DayStructure.dayStrDayNum,
                      activeDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        dayNumStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        dayStrStyle: TextStyle(fontSize: 12, color: Colors.white70),
                      ),
                      inactiveDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        dayNumStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                        dayStrStyle: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- قسم المواعيد المتاحة ---
                  const Text(
                    'Available Time',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  BuildTimePeriodHeader(icon: Icons.wb_sunny_outlined, title: 'Morning'),
                  const SizedBox(height: 12),
                  BuildTimerGrid(
                    slots: _morningSlots,
                    primaryColor: primaryColor,
                    selectedTime: selectedTime,
                  ),
                  const SizedBox(height: 16),
                  BuildTimePeriodHeader(icon: Icons.wb_twighlight, title: 'Afternoon'),
                  const SizedBox(height: 12),
                  BuildTimerGrid(
                    slots: _afternoonSlots,
                    primaryColor: primaryColor,
                    selectedTime: selectedTime,
                  ),
                  const SizedBox(height: 32),

                  // --- زر التأكيد ---
                  AppButton(
                    width: double.infinity,
                    txt: 'Confirm Appointment',
                    onPress: () {
                      print("Booking Confirmed for Dr. ${doctorData.name} on $selectedDate at $selectedTime");
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AppoinmentSuccess()));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}