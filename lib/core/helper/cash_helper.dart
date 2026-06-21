import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  // إنشاء كائن ثابت (Singleton)
  static final SecureStorageHelper instance = SecureStorageHelper._internal();
  factory SecureStorageHelper() => instance;
  SecureStorageHelper._internal();

  // إعدادات التخزين لضمان أقصى درجات الأمان
  static const _storage =  FlutterSecureStorage();

  // مفتاح ثابت للرمز (Token)
  static const String _keyToken = 'auth_token';

  // حفظ الرمز
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  // استرجاع الرمز
 static Future<String?> getToken() async {
    return await _storage.read(key: _keyToken);
  }

  // حذف الرمز (عند تسجيل الخروج)
 static Future<void> deleteToken() async {
    await _storage.delete(key: _keyToken);
  }

  // حذف كل البيانات المخزنة
  static Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}