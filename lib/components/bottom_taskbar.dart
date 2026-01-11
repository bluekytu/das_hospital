import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomTaskbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomTaskbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'Patient Details', 'icon': Icons.person},
      {'label': 'Book Appointment', 'icon': Icons.calendar_today},
      {'label': 'Main', 'icon': Icons.home},
      {'label': 'Past Visits', 'icon': Icons.history},
      {'label': 'Reports', 'icon': Icons.assessment},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              items.length,
              (index) {
                final item = items[index];
                final isMain = index == 2;
                final isSelected = currentIndex == index;

                return GestureDetector(
                  onTap: () => onTap(index),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: isMain ? 86 : 64,
                      minHeight: isMain ? 86 : 64,
                      maxWidth: isMain ? 120 : 100,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [Colors.teal[600]!, Colors.teal[400]!],
                              )
                            : LinearGradient(
                                colors: [
                                  Colors.grey[300]!,
                                  Colors.grey[200]!,
                                ],
                              ),
                        borderRadius: BorderRadius.circular(isMain ? 20 : 12),
                        boxShadow: [
                          BoxShadow(
                            color: (isSelected ? Colors.teal[400] : Colors.grey)!
                                .withOpacity(0.25),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            color: isSelected ? Colors.white : Colors.teal[700],
                            size: isMain ? 32 : 24,
                          ),
                          const SizedBox(height: 6),
                          Flexible(
                            child: Text(
                              item['label'] as String,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                fontSize: isMain ? 12 : 10,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : Colors.teal[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
