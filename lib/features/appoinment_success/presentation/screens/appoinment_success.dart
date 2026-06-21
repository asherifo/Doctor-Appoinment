import 'package:doctor_appoinment/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppoinmentSuccess extends StatefulWidget {
  const AppoinmentSuccess({super.key});

  @override
  State<AppoinmentSuccess> createState() => _AppoinmentSuccessState();
}

class _AppoinmentSuccessState extends State<AppoinmentSuccess> with TickerProviderStateMixin {
  late final AnimationController _lottieController;

  @override
  void initState() {
    super.initState();

    //  تهيئة الـ Controller بتاع الأنميشن
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _lottieController.dispose(); // حماية من الـ Memory Leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // أو أي لون خلفية تحبه
      body: Stack(
        children: [
          // 1. الأنميشن في منتصف الشاشة تماماً
          Center(
            child: Lottie.asset(
              'assets/animations/check.json',
              height: 400, //  صغرنا الارتفاع شوية عشان يسيب مساحة وميغطيش على الشاشة كلها

              controller: _lottieController,
              onLoaded: (composition) {
                // أول ما الملف يحمل، بنخليه يشتغل مرة واحدة بالظبط بناءً على وقته الحقيقي
                _lottieController
                  ..duration = composition.duration
                  ..forward().then((_) {
                    //  اختياري: لو عايزه ينقل تلقائي أول ما الأنميشن يخلص تماماً لشاشة الـ Home:
                    // Navigator.pushNamedAndRemoveUntil(context, 'Home', (route) => false);
                  });
              },
            ),
          ),

          // 2. زرار الـ Home فوق على اليمين بطريقة احترافية وآمنة
          Positioned(
            top: 50, // مسافة آمنة من أعلى الشاشة تحت الـ StatusBar
            right: 20, // مسافة من اليمين
            child: ElevatedButton(
              onPressed: () {
                // ينظف الـ Stack ويرجع للـ Home عشان المستخدم ميعرفش يعمل Back لشاشة النجاح تاني
                Navigator.pushNamedAndRemoveUntil(context, 'Home', (route) => false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary, // لون الـ زرار الأساسي بتاعك
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text(
                'Home',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}