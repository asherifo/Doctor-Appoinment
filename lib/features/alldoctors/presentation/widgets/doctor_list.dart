import 'package:doctor_appoinment/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../logic/cubit.dart';
import '../../logic/states.dart';
import 'doctor_card.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllDoctorsCubit, AllDoctorsState>(
      builder: (context, state) {
        if (state is AllDoctorLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AllDoctorSuccessState) {
          final doctorsList = state.doctors; // 🎯 بنقرأ اللستة الموحدة مباشرة وبسهولة

          if (doctorsList.isEmpty) {
            return  Center(
              child: SafeArea(
                child: Column(
                  children: [
                    
                  Lottie.asset('assets/animations/not_found.json',height:120, ),
                  SizedBox(height: 20,),
                    Text('NOT FOUND DATA !',style: TextStyle(fontSize: 20,color: AppColors.secondary),)
                ],),
              )
              
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: doctorsList.length,
            itemBuilder: (context, index) {
              return DoctorCard(data: doctorsList[index]);
            },
          );
        }

        if (state is AllDoctorErrorState) {
          return Center(
            child: Text(
              state.errorMsg,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        }

        return const Center(child: Text('ابدأ بتصفح الأطباء'));
      },
    );
  }
}