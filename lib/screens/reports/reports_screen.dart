import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedVisit;
  String? _selectedTest;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Reports',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.teal[800],
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.teal[700],
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Colors.teal[600],
          tabs: const [
            Tab(text: 'Laboratory'),
            Tab(text: 'Radiology'),
            Tab(text: 'Medical Report'),
            Tab(text: 'Sick Leave'),
            Tab(text: 'In-Demand'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildLaboratoryTab(),
          _buildEmptyTab('Radiology', Icons.image_not_supported),
          _buildEmptyTab('Medical Report', Icons.file_present),
          _buildEmptyTab('Sick Leave', Icons.sick),
          _buildEmptyTab('In-Demand Reports', Icons.assignment_turned_in),
        ],
      ),
    );
  }

  Widget _buildLaboratoryTab() {
    List<Map<String, String>> visits = [
      {'date': 'December 5, 2024', 'doctor': 'Dr. Sarah Johnson'},
      {'date': 'November 20, 2024', 'doctor': 'Dr. Ahmed Ali'},
      {'date': 'October 15, 2024', 'doctor': 'Dr. Mohammed Hassan'},
    ];

    List<Map<String, String>> testsForVisit(String visit) {
      if (visit == 'December 5, 2024') {
        return [
          {'name': 'Blood Glucose', 'value': '110', 'unit': 'mg/dL', 'normal': '70-100', 'status': 'high'},
          {'name': 'Hemoglobin', 'value': '13.2', 'unit': 'g/dL', 'normal': '13.5-17.5', 'status': 'low'},
          {'name': 'Cholesterol', 'value': '200', 'unit': 'mg/dL', 'normal': '<200', 'status': 'normal'},
        ];
      } else if (visit == 'November 20, 2024') {
        return [
          {'name': 'White Blood Cells', 'value': '7.5', 'unit': 'K/µL', 'normal': '4.5-11', 'status': 'normal'},
          {'name': 'Platelets', 'value': '250', 'unit': 'K/µL', 'normal': '150-400', 'status': 'normal'},
        ];
      } else {
        return [
          {'name': 'Creatinine', 'value': '1.1', 'unit': 'mg/dL', 'normal': '0.7-1.3', 'status': 'normal'},
          {'name': 'Uric Acid', 'value': '8.5', 'unit': 'mg/dL', 'normal': '<7', 'status': 'high'},
        ];
      }
    }

    if (_selectedVisit == null) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select a Visit',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal[800],
                ),
              ),
              const SizedBox(height: 12),
              ...visits.map((visit) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedVisit = visit['date'];
                        _selectedTest = null;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.teal[200]!, width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                visit['date']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal[800],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                visit['doctor']!,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.teal[600]),
                        ],
                      ),
                    ),
                  ))
              ,
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    } else if (_selectedTest == null) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedVisit = null;
                  });
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.teal[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Back to Visits',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tests - $_selectedVisit',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal[800],
                ),
              ),
              const SizedBox(height: 12),
              ...testsForVisit(_selectedVisit!).map((test) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTest = test['name'];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: test['status'] == 'normal'
                              ? Colors.green[200]!
                              : test['status'] == 'high'
                                  ? Colors.orange[200]!
                                  : Colors.red[200]!,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                test['name']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[800],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${test['value']} ${test['unit']}',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: test['status'] == 'normal'
                                  ? Colors.green[100]
                                  : test['status'] == 'high'
                                      ? Colors.orange[100]
                                      : Colors.red[100],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              test['status']!.toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: test['status'] == 'normal'
                                    ? Colors.green[700]
                                    : test['status'] == 'high'
                                        ? Colors.orange[700]
                                        : Colors.red[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              ,
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    } else {
      final test = testsForVisit(_selectedVisit!).firstWhere(
        (t) => t['name'] == _selectedTest,
      );
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTest = null;
                  });
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.teal[600]),
                    const SizedBox(width: 8),
                    Text(
                      'Back to Tests',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                test['name']!,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.teal[800],
                ),
              ),
              const SizedBox(height: 24),
              _buildTestDetailCard('Value', '${test['value']} ${test['unit']}'),
              _buildTestDetailCard('Normal Range', test['normal']!),
              _buildTestDetailCard('Status', test['status']!.toUpperCase()),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: test['status'] == 'normal'
                      ? Colors.green[50]
                      : test['status'] == 'high'
                          ? Colors.orange[50]
                          : Colors.red[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: test['status'] == 'normal'
                        ? Colors.green[200]!
                        : test['status'] == 'high'
                            ? Colors.orange[200]!
                            : Colors.red[200]!,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Interpretation',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: test['status'] == 'normal'
                            ? Colors.green[800]
                            : test['status'] == 'high'
                                ? Colors.orange[800]
                                : Colors.red[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      test['status'] == 'normal'
                          ? 'Your test result is within normal range.'
                          : test['status'] == 'high'
                              ? 'Your test result is above the normal range. Please consult your doctor.'
                              : 'Your test result is below the normal range. Please consult your doctor.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: test['status'] == 'normal'
                            ? Colors.green[700]
                            : test['status'] == 'high'
                                ? Colors.orange[700]
                                : Colors.red[700],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildTestDetailCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.teal[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTab(String tabName, IconData icon) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No $tabName Available',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
