import 'package:doctor_appoinment/core/utils/app_colors.dart';
import 'package:doctor_appoinment/features/alldoctors/data/all_doctor_model.dart';
import 'package:doctor_appoinment/features/doctor_detail/presentation/doctor_details_screen.dart';
import 'package:flutter/material.dart';
import '../../data/search_doctor_model.dart'; // 🎯 استيراد الموديل الجديد الموحد

class DoctorCard extends StatelessWidget {
  final DoctorModel data;
// 🎯 بقت final واستخدمنا الموديل الموحد

  const DoctorCard({super.key, required this.data,}); // كونسراكتور نضيف

  @override
  Widget build(BuildContext context) {
    final Color badgeColor = const Color(0xFFE8E8E8);
    final Color dotColor = AppColors.primary;
    final Color badgeTextColor = Colors.black;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    data.photo, // 🎯 شيلنا الـ ! لأن الموديل الجديد غير قابل للـ null (Non-nullable)
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 75,
                      height: 75,
                      color: Colors.blue.shade100,
                      child: const Icon(Icons.person, size: 40, color: Colors.blue),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: dotColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              data.startTime, // 🎯 بدون !
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: badgeTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 4),
                          Text("4.8", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                          SizedBox(width: 4),
                          Text('(112 reviews)', style: TextStyle(fontSize: 13, color: Color(0xFF64748B))),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.call, color: AppColors.primary, size: 18),
                          Text(data.phone, style: TextStyle(color: AppColors.primary)), // 🎯 بدون !
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(data.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
            const SizedBox(height: 4),
            Text(data.specialization.name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1D4ED8))),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF64748B)),
                const SizedBox(width: 6),
                Text(data.city.name, style: const TextStyle(fontSize: 13, color: Color(0xFF475569))),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.payments_outlined, size: 16, color: Color(0xFF64748B)),
                const SizedBox(width: 6),
                Text(data.appointPrice.toString(), style: const TextStyle(fontSize: 13, color: Color(0xFF475569))),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0),
              child: Divider(color: Color(0xFFF1F5F9), thickness: 1.5),
            ),
            Row(
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFCBD5E1)),
                  ),
                  child: const Icon(Icons.favorite_border, color: Color(0xFF1E293B), size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF0284C7)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('View Profile', maxLines: 1, softWrap: false, style: TextStyle(color: Color(0xFF0369A1), fontWeight: FontWeight.w700, fontSize: 11)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'DetailAndBooking',arguments: data);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF004B93),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('Book Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}