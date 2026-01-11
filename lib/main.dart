// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/splash_screen.dart';
import 'pages/login_page.dart';
import 'pages/otp_page.dart';
import 'pages/branch_selection.dart';
import 'screens/hospital_app.dart';
import 'screens/patient_demographics/patient_demographics.dart';
import 'screens/past_visits/past_visits.dart';
import 'screens/reports/reports_screen.dart';

void main() {
  runApp(const DoctorAppointment());
}

class DoctorAppointment extends StatelessWidget {
  const DoctorAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hospital App",
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const SplashScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginPage(),
        '/otp': (context) => const OTPPage(),
        '/facility': (context) => const FacilityPageSelect(),
        '/home': (context) => const HospitalApp(),
        '/patient_details': (context) => const PatientDemographicsPage(),
        '/past_visits': (context) => const PastVisitsPage(),
        '/reports': (context) => const ReportsScreen(),
      },
    );
  }
}

class  FacilityPageSelect extends StatefulWidget {
  const FacilityPageSelect({super.key});

  @override
  State<FacilityPageSelect> createState() => _FacilityPageSelectState();
}

class _FacilityPageSelectState extends State<FacilityPageSelect> {
  
  int selectedFacility = -1;
  //search bar initialization
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  final facilities = const [
    //placeholder facilities
    {"name": "German Hospital", "location": "Sharjah"},
    {"name": "Shifa Hospital", "location": "Dubai"},
    {"name": "Abdullah Hospital", "location": "Abu Dhabi"},
    {"name": "Al Noor Hospital", "location": "Ajman"},
    {"name": "City Care Hospital", "location": "Ras Al Khaimah"},
    {"name": "Health Plus Clinic", "location": "Fujairah"},
    {"name": "Wellness Center", "location": "Umm Al Quwain"},
    {"name": "Mediclinic", "location": "Dubai"},
    {"name": "NMC Specialty Hospital", "location": "Abu Dhabi"},
    {"name": "Aster Hospital", "location": "Sharjah"},
    {"name": "Prime Hospital", "location": "Dubai"},
    {"name": "Royal Hospital", "location": "Abu Dhabi"},
  ];
  
  List<Map<String, String>> get filteredFacilities {
    if (searchQuery.isEmpty) {
      return facilities;
    } else {
      return facilities
          .where((facility) =>
              facility['name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
              facility['location']!.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 24
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Book Appointment",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.5,
              )
            )
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
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[100]!, Colors.grey[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
          )
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            const stepIndicator (
              currentStep: 1,
              totalSteps: 5,
              labels: [
                "Facility",
                "Branch",
                "Department",
                "Doctor",
                "Date & Time "
              ],
            ),
           const SizedBox(height: 30),

            // Section Title
            Text(
              "Select Facility",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 600 ? 22 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Choose your preferred healthcare facility",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 600 ? 14 : 12,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 20),
            
            //search bar functionality
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    selectedFacility = -1; //reset selection on new search
                  });
                },
                decoration: InputDecoration(
                  hintText: "Search facilities...",
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: MediaQuery.of(context).size.width > 600 ? 14 : 13,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.teal, size: 22),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.teal, size: 20),
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                              searchQuery = "";
                            });
                          },
                        )
                      : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Grid view for facilities (replaces horizontal ListView)
            Expanded(
              child: filteredFacilities.isEmpty 
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 50, color: Colors.grey[400]),
                        const SizedBox(height: 10),
                        Text(
                          "No facilities found",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width > 600 ? 14 : 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, 
                      childAspectRatio: 0.95, 
                      crossAxisSpacing: 16,                       
                      mainAxisSpacing: 16, 
                    ),
                    itemCount: filteredFacilities.length,
                    itemBuilder: (context, index) {
                      final facility = filteredFacilities[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BranchPageSelect(
                                facilityName: facility['name']!,
                              ),
                            ),
                          );
                        },
                        child: FacilityCard(
                          name: facility['name']!,
                          location: facility['location']!,
                          isSelected: selectedFacility == index,
                        ),
                      );
                    },
                  ),
            ),

            const SizedBox(height: 16),
            
            if (selectedFacility != -1) 
              Container(
                margin: const EdgeInsets.only(bottom: 15, top: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal[200]!, width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.teal[700], size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "Next: Select Branch",
                      style: TextStyle(
                        color: Colors.teal[700],
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width > 600 ? 13 : 11
                      ),
                    )
                  ],
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class stepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> labels;

  const stepIndicator({
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

//resuable facilitycard class, can add as many facilities as required
class FacilityCard extends StatelessWidget {
  final String name;
  final String location;
  final bool isSelected;

  const FacilityCard({
    super.key,
    required this.name,
    required this.location,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        // gradient background to cards
        gradient: isSelected
            ? LinearGradient(
                colors: [Colors.teal[50]!, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isSelected ? null : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: isSelected ? Border.all(color: Colors.teal, width: 4) : null,
        // dramatic shadow effect
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? Colors.teal.withOpacity(0.4)
                : Colors.grey.withOpacity(0.15),
            blurRadius: isSelected ? 16 : 8,
            offset: Offset(0, isSelected ? 6 : 3),
            spreadRadius: isSelected ? 2 : 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //  container with subtle background to icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.teal[100] : Colors.teal[50],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.local_hospital,
                  color: isSelected ? Colors.teal[700] : Colors.teal,
                  size: 36,
                ),
              ),
              const SizedBox(height: 10),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.teal[800] : Colors.black,
                      fontSize: MediaQuery.of(context).size.width > 600 ? 13 : 11,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on,
                    size: 14,
                    color: isSelected ? Colors.teal[600] : Colors.grey,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    location,
                    style: TextStyle(
                      color: isSelected ? Colors.teal : Colors.grey,
                      fontSize: MediaQuery.of(context).size.width > 600 ? 12 : 10,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // checkmark icon on selected cards
          if (isSelected)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
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
            ),
        ],
      ),
    );
  }
}