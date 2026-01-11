import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'date_time_selection.dart';

class DoctorPageSelect extends StatefulWidget {
  final String facilityName;
  final String branchName;
  final String departmentName;

  const DoctorPageSelect({
    super.key,
    required this.facilityName,
    required this.branchName,
    required this.departmentName,
  });

  @override
  State<DoctorPageSelect> createState() => _DoctorPageSelectState();
}

class _DoctorPageSelectState extends State<DoctorPageSelect> {
  int selectedDoctor = -1;

  // Placeholder doctors with names, nearest appointment dates, and profile pictures
  final doctors = const [
    {
      "name": "Dr. Ahmed Hassan",
      "speciality": "Cardiologist",
      "nextAppointment": "Today, 2:30 PM",
      "image": "👨‍⚕️"
    },
    {
      "name": "Dr. Fatima Al Mansouri",
      "speciality": "Cardiologist",
      "nextAppointment": "Tomorrow, 10:00 AM",
      "image": "👩‍⚕️"
    },
    {
      "name": "Dr. Mohammed Al Mazrouei",
      "speciality": "Cardiologist",
      "nextAppointment": "Nov 20, 3:15 PM",
      "image": "👨‍⚕️"
    },
    {
      "name": "Dr. Sarah Johnson",
      "speciality": "Cardiologist",
      "nextAppointment": "Nov 21, 1:45 PM",
      "image": "👩‍⚕️"
    },
    {
      "name": "Dr. Omar Al Kaabi",
      "speciality": "Cardiologist",
      "nextAppointment": "Nov 22, 11:00 AM",
      "image": "👨‍⚕️"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.person_4,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Select Doctor",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal[700]!, Colors.teal[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[100]!, Colors.grey[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// STEP INDICATOR — Step 4 of 5
              const StepIndicator(
                currentStep: 4,
                totalSteps: 5,
                labels: [
                  "Facility",
                  "Branch",
                  "Department",
                  "Doctor",
                  "Date & Time"
                ],
              ),

              const SizedBox(height: 20),

              /// Selected Facility + Branch + Department Info
              _infoCard(),

              const SizedBox(height: 30),

              Text(
                "Select Doctor",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Choose your preferred doctor in ${widget.departmentName}",
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              const SizedBox(height: 20),

              /// Doctor List
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = doctors[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DateTimePageSelect(
                              facilityName: widget.facilityName,
                              branchName: widget.branchName,
                              departmentName: widget.departmentName,
                              doctorName: doctor['name']!,
                              doctorImage: doctor['image']!,
                              doctorSpeciality: doctor['speciality']!,
                            ),
                          ),
                        );
                      },
                      child: DoctorCard(
                        name: doctor['name']!,
                        speciality: doctor['speciality']!,
                        nextAppointment: doctor['nextAppointment']!,
                        image: doctor['image']!,
                        isSelected: selectedDoctor == index,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Info card showing selected facility, branch, and department
  Widget _infoCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal[200]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  "${widget.facilityName} • ${widget.branchName} • ${widget.departmentName}",
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: Colors.teal[800],
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Info card shown after doctor selection
}

/// Doctor Card Widget
class DoctorCard extends StatelessWidget {
  final String name;
  final String speciality;
  final String nextAppointment;
  final String image;
  final bool isSelected;

  const DoctorCard({
    super.key,
    required this.name,
    required this.speciality,
    required this.nextAppointment,
    required this.image,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(
                colors: [Colors.teal[50]!, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isSelected ? null : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isSelected ? Border.all(color: Colors.teal, width: 3) : null,
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? Colors.teal.withOpacity(0.4)
                : Colors.grey.withOpacity(0.1),
            blurRadius: isSelected ? 12 : 6,
            offset: Offset(0, isSelected ? 4 : 2),
            spreadRadius: isSelected ? 1 : 0,
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          /// Profile Picture (Emoji Placeholder)
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.teal[100],
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.teal : Colors.teal[200]!,
                width: isSelected ? 3 : 1,
              ),
            ),
            child: Center(
              child: Text(
                image,
                style: const TextStyle(fontSize: 40),
              ),
            ),
          ),
          const SizedBox(width: 14),

          /// Doctor Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.teal[800] : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3),
                Text(
                  speciality,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 14,
                      color: isSelected ? Colors.teal[600] : Colors.grey[500],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      nextAppointment,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isSelected ? Colors.teal[600] : Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Selection Indicator
          if (isSelected)
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.5),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              ),
            ),
        ],
      ),
    );
  }
}

/// Step Indicator Widget (reused from other pages)
class StepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> labels;

  const StepIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Progress Bar
        Row(
          children: List.generate(totalSteps, (index) {
            final isCompleted = index < currentStep;
            final isCurrent = index == currentStep - 1;

            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: BoxDecoration(
                        color: isCompleted || isCurrent
                            ? Colors.teal
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  if (index < totalSteps - 1)
                    Container(
                      width: 8,
                      height: 4,
                      color: Colors.transparent,
                    ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 8),

        // Step Labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(totalSteps, (index) {
            final isCurrent = index == currentStep - 1;
            final isCompleted = index < currentStep;

            return Expanded(
              child: Text(
                labels[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > 600 ? 11 : 9,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                  color: isCurrent
                      ? Colors.teal
                      : isCompleted
                          ? Colors.teal[300]
                          : Colors.grey[500],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

