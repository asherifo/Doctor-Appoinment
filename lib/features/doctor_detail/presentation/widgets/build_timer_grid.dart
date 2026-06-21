import 'package:doctor_appoinment/features/doctor_detail/logic/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuildTimerGrid extends StatelessWidget {
   BuildTimerGrid({super.key, required this.slots, required this.primaryColor,required this.selectedTime});
  final List<Map<String, dynamic>> slots;
  final Color primaryColor;
  final String? selectedTime;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorsCubit>();
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: slots.map((slot) {
        final String time = slot["time"];
        final bool isAvailable = slot["available"];
        final bool isSelected = selectedTime == time;

        return InkWell(
          onTap: isAvailable
              ? () {
            cubit.changeSelectedTime(time);
          }
              : null,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.28,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: !isAvailable
                  ? Colors.grey[100]
                  : isSelected
                  ? const Color(0xFFD2E4F6)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: !isAvailable
                    ? Colors.transparent
                    : isSelected
                    ? primaryColor
                    : Colors.grey[300]!,
              ),
            ),
            child: Center(
              child: Text(
                time,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: !isAvailable
                      ? Colors.grey[400]
                      : isSelected
                      ? primaryColor
                      : Colors.black87,
                  decoration: !isAvailable ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
