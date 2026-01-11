import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/bottom_taskbar.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 4;

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

  void _onTaskbarTap(int index) {
    setState(() {
      _currentTabIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.of(context).pushReplacementNamed('/patient_details');
        break;
      case 1:
        Navigator.of(context).pushReplacementNamed('/book_appointment');
        break;
      case 2:
        Navigator.of(context).pushReplacementNamed('/home');
        break;
      case 3:
        Navigator.of(context).pushReplacementNamed('/past_visits');
        break;
      case 4:
        break;
    }
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
          _buildRadiologyTab(),
          _buildMedicalReportTab(),
          _buildSickLeaveTab(),
          _buildInDemandTab(),
        ],
      ),
      bottomNavigationBar: BottomTaskbar(
        currentIndex: _currentTabIndex,
        onTap: _onTaskbarTap,
      ),
    );
  }

  Widget _buildLaboratoryTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildVisitCard(
              visitDate: 'December 5, 2024',
              doctorName: 'Dr. Ahmed Ali',
              onTap: () {
                _showTestsDialog(
                  'December 5, 2024',
                  [
                    {'name': 'Blood Glucose', 'value': '110', 'unit': 'mg/dL', 'normal': '70-100', 'status': 'above'},
                    {'name': 'Hemoglobin', 'value': '13.2', 'unit': 'g/dL', 'normal': '13.5-17.5', 'status': 'below'},
                    {'name': 'Cholesterol', 'value': '200', 'unit': 'mg/dL', 'normal': '<200', 'status': 'normal'},
                  ],
                );
              },
            ),
            _buildVisitCard(
              visitDate: 'November 20, 2024',
              doctorName: 'Dr. Sarah Johnson',
              onTap: () {
                _showTestsDialog(
                  'November 20, 2024',
                  [
                    {'name': 'White Blood Cells', 'value': '7.5', 'unit': 'K/µL', 'normal': '4.5-11', 'status': 'normal'},
                    {'name': 'Platelets', 'value': '250', 'unit': 'K/µL', 'normal': '150-400', 'status': 'normal'},
                  ],
                );
              },
            ),
            _buildVisitCard(
              visitDate: 'October 15, 2024',
              doctorName: 'Dr. Mohammed Hassan',
              onTap: () {
                _showTestsDialog(
                  'October 15, 2024',
                  [
                    {'name': 'Creatinine', 'value': '1.1', 'unit': 'mg/dL', 'normal': '0.7-1.3', 'status': 'normal'},
                    {'name': 'Uric Acid', 'value': '8.5', 'unit': 'mg/dL', 'normal': '<7', 'status': 'above'},
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadiologyTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No Radiology Reports',
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

  Widget _buildMedicalReportTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.file_present, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No Medical Reports',
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

  Widget _buildSickLeaveTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sick, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No Sick Leave Issued',
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

  Widget _buildInDemandTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_turned_in, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No In-Demand Reports',
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

  Widget _buildVisitCard({
    required String visitDate,
    required String doctorName,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.teal[200]!, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  visitDate,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doctorName,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal[600]),
          ],
        ),
      ),
    );
  }

  void _showTestsDialog(String visitDate, List<Map<String, String>> tests) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tests - $visitDate',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal[800],
                ),
              ),
              const SizedBox(height: 20),
              ...tests.map((test) => _buildTestItem(test)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTestItem(Map<String, String> test) {
    final isAbove = test['status'] == 'above';
    final isBelow = test['status'] == 'below';
    final isNormal = test['status'] == 'normal';

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(test['name'] ?? ''),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Value:'),
                    Text(
                      '${test['value']} ${test['unit']}',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Normal Range:'),
                    Text(test['normal'] ?? ''),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status:'),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isNormal
                            ? Colors.green[100]
                            : isAbove
                                ? Colors.orange[100]
                                : Colors.red[100],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isNormal
                            ? 'Normal'
                            : isAbove
                                ? 'Above Normal'
                                : 'Below Normal',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isNormal
                              ? Colors.green[700]
                              : isAbove
                                  ? Colors.orange[700]
                                  : Colors.red[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isNormal
                ? Colors.green[200]!
                : isAbove
                    ? Colors.orange[200]!
                    : Colors.red[200]!,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  test['name'] ?? '',
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isNormal
                        ? Colors.green[100]
                        : isAbove
                            ? Colors.orange[100]
                            : Colors.red[100],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    isNormal
                        ? 'Normal'
                        : isAbove
                            ? 'High'
                            : 'Low',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isNormal
                          ? Colors.green[700]
                          : isAbove
                              ? Colors.orange[700]
                              : Colors.red[700],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Normal: ${test['normal']}',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    color: Colors.grey[500],
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
