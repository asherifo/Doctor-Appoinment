import 'package:doctor_appoinment/features/alldoctors/data/all_doctor_model.dart';
import 'package:doctor_appoinment/features/alldoctors/data/search_doctor_model.dart';
import 'package:doctor_appoinment/features/alldoctors/presentation/screen/all_doctors_screen.dart';
import 'package:doctor_appoinment/features/auth/presentation/Screens/login_screen.dart';
import 'package:doctor_appoinment/features/auth/presentation/Screens/register_screen.dart';
import 'package:doctor_appoinment/features/doctor_detail/presentation/doctor_details_screen.dart';
import 'package:flutter/material.dart';

import '../features/splash/presentation/screens/splash_screen.dart';

class AppRouter {
 static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
  // شاشة تسجيل الدخول
   case 'Login':
    return MaterialPageRoute(builder: (_) => LoginScreen());
    case 'Splash':
    return MaterialPageRoute(builder: (_) => SplashScreen());

  // شاشة إنشاء حساب جديد
   case 'Register':
    return MaterialPageRoute(builder: (_) => RegisterScreen());

  // شاشة جميع الأطباء والبحث
   case 'AllDoctors':
    return MaterialPageRoute(builder: (_) => const FindDoctorScreen());

  // الشاشة المطلوبة: تفاصيل الطبيب والحجز مع استقبال البيانات المرسلة بأمان
   case 'DetailAndBooking':
    final doctorData = settings.arguments as DoctorModel; // التقاط كائن الطبيب من الـ Card
    return MaterialPageRoute(
     builder: (_) => DoctorBookingScreen(doctorData: doctorData,),
    );

   default:
    return null;
  }
 }
}