import 'package:dio/dio.dart';
import 'package:doctor_appoinment/core/const/api_const.dart';
import 'package:doctor_appoinment/core/helper/cash_helper.dart';
import 'package:doctor_appoinment/core/helper/dio_helper.dart';
import 'package:doctor_appoinment/features/auth/data/auth_response_model.dart';
import 'package:doctor_appoinment/features/auth/data/login_model.dart';
import 'package:doctor_appoinment/features/auth/data/register_model.dart';
import 'package:doctor_appoinment/features/auth/logic/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{
  Dio dio = Dio();

  AuthCubit():super(AuthInitialState());

   Future register(RegisterRequestModel body) async{
     emit(RegisterLoadingState());
     try{
        final response = await dio.post(ApiConst.register,data: body.toJson());
        if(response.statusCode == 200 ){
          final result = AuthResponseModel.fromJson(response.data);
           SecureStorageHelper.saveToken(result.data!.token);
          emit(RegisterSuccessState());
        }

     }on DioException catch (e){
       emit(RegisterErrorState(errorMsg: DioExceptionHelper.fromDioException(e)));
     }
   }
  Future login(LoginModel body) async{
    emit(AuthLoadingState());
    try{
      final response = await dio.post(ApiConst.login,data: body.toJson());
      if(response.statusCode == 200 ){
        final result =  AuthResponseModel.fromJson(response.data);
        final token = result.data?.token;

        if (token != null) {
          await SecureStorageHelper.saveToken(token);
          emit(AuthSuccessState());
        }else {
          // Handle the case where the API returned 200 but no token was found
          emit(AuthErrorState(errorMsg: "Login failed: No token received"));
        }


      }

    }on DioException catch (e){
      emit(AuthErrorState(errorMsg: DioExceptionHelper.fromDioException(e)));
    }
  }
}