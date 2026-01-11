import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PastVisitsPage extends StatefulWidget {
  const PastVisitsPage({super.key});

  @override
  State<PastVisitsPage> createState() => _PastVisitsPageState();
}

class _PastVisitsPageState extends State<PastVisitsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Past Visits',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.teal[800],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildVisitCard(
                date: 'December 5, 2024',
                doctorName: 'Dr. Sarah Johnson',
                department: 'Cardiology',
                diagnosis: 'Regular checkup - All vitals normal',
                notes: 'Continue with regular exercise and heart-healthy diet',
              ),
              _buildVisitCard(
                date: 'November 20, 2024',
                doctorName: 'Dr. Ahmed Ali',
                department: 'General Medicine',
                diagnosis: 'Mild hypertension detected',
                notes: 'Prescribed Lisinopril 10mg daily. Follow-up in 2 weeks',
              ),
              _buildVisitCard(
                date: 'October 15, 2024',
                doctorName: 'Dr. Mohammed Hassan',
                department: 'Endocrinology',
                diagnosis: 'Type 2 Diabetes - Controlled',
                notes: 'Blood sugar levels stable. Continue current medications',
              ),
              _buildVisitCard(
                date: 'September 30, 2024',
                doctorName: 'Dr. Fatima Khan',
                department: 'Ophthalmology',
                diagnosis: 'Mild myopia with astigmatism',
                notes: 'Prescribed new glasses. No urgent intervention needed',
              ),
              _buildVisitCard(
                date: 'August 18, 2024',
                doctorName: 'Dr. John Smith',
                department: 'Orthopedics',
                diagnosis: 'Back pain from poor posture',
                notes: 'Physical therapy recommended. Avoid heavy lifting',
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVisitCard({
    required String date,
    required String doctorName,
    required String department,
    required String diagnosis,
    required String notes,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
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
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Department', department),
                  const SizedBox(height: 12),
                  _buildDetailRow('Diagnosis', diagnosis),
                  const SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notes',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.teal[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          notes,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.teal[700],
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}
