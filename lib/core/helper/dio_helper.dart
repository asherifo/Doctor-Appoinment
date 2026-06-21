import 'package:dio/dio.dart';

class DioExceptionHelper {
  static String fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return "انتهت مهلة الاتصال بالخادم. يرجى التحقق من الإنترنت.";
      case DioExceptionType.sendTimeout:
        return "فشلت عملية إرسال البيانات إلى السيرفر (Timeout).";
      case DioExceptionType.receiveTimeout:
        return "استغرق السيرفر وقتاً طويلاً للرد. حاول مرة أخرى.";
      case DioExceptionType.badCertificate:
        return "خطأ في شهادة الأمان الخاصة بالسيرفر (Bad Certificate).";
      case DioExceptionType.badResponse:
        return _handleBadResponse(dioException.response);
      case DioExceptionType.cancel:
        return "تم إلغاء طلب الاتصال بالخادم.";
      case DioExceptionType.connectionError:
        return "لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة.";
      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ?? false) {
          return "خطأ في الشبكة. تعذر الوصول إلى السيرفر.";
        }
        return "حدث خطأ غير معروف.";
      default:
        return "حدث خطأ غير متوقع.";
    }
  }

  static String _handleBadResponse(Response? response) {
    int? statusCode = response?.statusCode;

    // 1. محاولة قراءة رسالة الخطأ المباشرة من السيرفر (لو بيبعت رسالة مخصصة)
    if (response?.data != null) {
      try {
        final data = response?.data;

        if (data is Map<String, dynamic>) {
          // فحص الكلمات المفتاحية الشهيرة للرسائل في الـ APIs
          final serverMessage = data['message'] ?? data['error'] ?? data['msg'];

          if (serverMessage != null) {
            if (serverMessage is List) {
              return serverMessage.join(', ');
            }
            // ترجمة ذكية لبعض رسائل السيرفر الشائعة لو جات بالإنجليزي
            return _translateAuthMessage(serverMessage.toString());
          }

          // قراءة أخطاء الـ Validation الفرعية (مثل الأخطاء الناتجة عن الـ Register)
          if (data['errors'] != null && data['errors'] is Map) {
            final errorsMap = data['errors'] as Map;
            if (errorsMap.isNotEmpty) {
              final firstError = errorsMap.values.first;
              if (firstError is List && firstError.isNotEmpty) {
                return _translateAuthMessage(firstError.first.toString());
              }
              return _translateAuthMessage(firstError.toString());
            }
          }
        }
      } catch (_) {
        // إذا فشل الـ Parsing، يكمل للـ الـ Status Codes تلقائياً
      }
    }

    // 2. تخصيص الـ Status Codes بالكامل لتناسب الـ Authentication لو السيرفر مبعتش رسالة
    switch (statusCode) {
      case 400:
        return "طلب غير صالح. يرجى التأكد من كتابة البيانات بشكل صحيح.";
      case 401:
        return "عذراً، البريد الإلكتروني أو كلمة المرور غير صحيحة.";
      case 403:
        return "غير مسموح لك بالدخول. قد يكون الحساب محظوراً أو غير مفعل.";
      case 404:
        return "هذا الحساب غير مسجل لدينا. يرجى إنشاء حساب جديد أولاً.";
      case 409:
        return "البريد الإلكتروني أو رقم الهاتف مسجل بالفعل بحساب آخر.";
      case 422:
        return "البيانات المدخلة غير صالحة (مثال: كلمة المرور ضعيفة جداً أو البريد غير صحيح).";
      case 500:
        return "مشكلة في سيرفر قاعدة البيانات. يرجى المحاولة لاحقاً.";
      case 503:
        return "السيرفر تحت الصيانة حالياً، جرب مجدداً بعد قليل.";
      default:
        return "عذراً! حدث خطأ في عملية التسجيل ($statusCode).";
    }
  }

  // دالة مساعدة لترجمة أشهر رسائل الـ Auth الراجعة من السيرفر بالإنجليزي كإجراء أمان إضافي
  static String _translateAuthMessage(String message) {
    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('email already exists') || lowerMessage.contains('email taken')) {
      return "البريد الإلكتروني مستخدم بالفعل.";
    }
    if (lowerMessage.contains('phone already exists') || lowerMessage.contains('phone taken')) {
      return "رقم الهاتف مستخدم بالفعل.";
    }
    if (lowerMessage.contains('invalid credentials') || lowerMessage.contains('wrong password')) {
      return "بيانات الدخول غير صحيحة. تأكد من البريد وكلمة المرور.";
    }
    if (lowerMessage.contains('user not found')) {
      return "المستخدم غير موجود.";
    }
    if (lowerMessage.contains('password is too short')) {
      return "كلمة المرور قصيرة جداً.";
    }

    return message; // لو ملهاش ترجمة جاهزة، يرجع رسالة السيرفر زي ما هي
  }
}