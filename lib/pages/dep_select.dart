import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './doctor_selection.dart';

class DepartmentPageSelect extends StatefulWidget {
  final String facilityName;
  final String branchName;

  const DepartmentPageSelect({
    super.key,
    required this.facilityName,
    required this.branchName,
  });

  @override
  State<DepartmentPageSelect> createState() => _DepartmentPageSelectState();
}

class _DepartmentPageSelectState extends State<DepartmentPageSelect> {
  int selectedDepartment = -1;

  // Placeholder department list
  final departments = const [
    {"name": "Cardiology", "speciality": "Heart & Blood Vessels"},
    {"name": "Orthopedics", "speciality": "Bones & Joints"},
    {"name": "Dermatology", "speciality": "Skin & Hair"},
    {"name": "Neurology", "speciality": "Brain & Nerves"},
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
                Icons.medical_services,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Select Department ",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
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

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// STEP INDICATOR — Step 3 of 5
            const StepIndicator(
              currentStep: 3,
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

            /// Selected Facility + Branch
            infoCard(),

            const SizedBox(height: 30),

            Text(
              "Select Department for ${widget.branchName}, ${widget.facilityName}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Choose the department for your appointment",
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 20),

            /// Department List
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: departments.length,
                itemBuilder: (context, index) {
                  final dept = departments[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorPageSelect(
                            facilityName: widget.facilityName,
                            branchName: widget.branchName,
                            departmentName: dept['name']!,
                          ),
                        ),
                      );
                    },
                    child: DepartmentCard(
                      name: dept['name']!,
                      speciality: dept['speciality']!,
                      isSelected: selectedDepartment == index,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.teal[600], size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "Facility: ${widget.facilityName}  →  Branch: ${widget.branchName}",
              style: TextStyle(color: Colors.grey[700], fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget nextInfoCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200, width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.teal[700], size: 20),
          const SizedBox(width: 8),
          const Text(
            "Next: Select Doctor →",
            style: TextStyle(
              color: Colors.teal,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

/// Department Card
class DepartmentCard extends StatelessWidget {
  final String name;
  final String speciality;
  final bool isSelected;

  const DepartmentCard({
    super.key,
    required this.name,
    required this.speciality,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: isSelected
            ? LinearGradient(
                colors: [Colors.teal.shade50, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isSelected ? null : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? Border.all(color: Colors.teal, width: 3) : null,
        boxShadow: [
          BoxShadow(
            color:
                isSelected ? Colors.teal.withOpacity(0.3) : Colors.grey.withOpacity(0.1),
            blurRadius: isSelected ? 12 : 6,
            offset: Offset(0, isSelected ? 4 : 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.teal[100] : Colors.teal[50],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              Icons.local_hospital,
              color: isSelected ? Colors.teal[700] : Colors.teal,
              size: 26,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.teal[800] : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  speciality,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          if (isSelected)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 20),
            ),
        ],
      ),
    );
  }
}

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

