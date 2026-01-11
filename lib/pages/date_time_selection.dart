import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'booking_confirmation.dart';

class DateTimePageSelect extends StatefulWidget {
  final String facilityName;
  final String branchName;
  final String departmentName;
  final String doctorName;
  final String doctorImage;
  final String doctorSpeciality;

  const DateTimePageSelect({
    super.key,
    required this.facilityName,
    required this.branchName,
    required this.departmentName,
    required this.doctorName,
    required this.doctorImage,
    required this.doctorSpeciality,
  });

  @override
  State<DateTimePageSelect> createState() => _DateTimePageSelectState();
}

class _DateTimePageSelectState extends State<DateTimePageSelect> {
  late DateTime _currentMonth;
  late DateTime _selectedDay;
  String? _selectedTime;

  // Mock availability data: date -> status (unavailable/available/closed)
  final Map<DateTime, String> dayStatus = {
    DateTime(2025, 11, 18): 'available',
    DateTime(2025, 11, 19): 'available',
    DateTime(2025, 11, 20): 'fully_booked',
    DateTime(2025, 11, 21): 'closed',
    DateTime(2025, 11, 22): 'available',
    DateTime(2025, 11, 23): 'available',
    DateTime(2025, 11, 24): 'available',
    DateTime(2025, 11, 25): 'fully_booked',
    DateTime(2025, 11, 26): 'closed',
    DateTime(2025, 11, 27): 'fully_booked',
    DateTime(2025, 11, 28): 'available',
    DateTime(2025, 11, 29): 'available',
    DateTime(2025, 11, 30): 'closed',
    DateTime(2025, 12, 1): 'available',
    DateTime(2025, 12, 2): 'available',
    DateTime(2025, 12, 3): 'available',
    DateTime(2025, 12, 4): 'fully_booked',
    DateTime(2025, 12, 5): 'closed',
    DateTime(2025, 12, 6): 'available',
  };

  // Available time slots
  final List<String> availableTimeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '02:00 PM',
    '02:30 PM',
    '03:00 PM',
    '03:30 PM',
  ];

  late ScrollController _scrollController;
  bool _showScrollToCalendarButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_updateScrollButtonVisibility);
    _currentMonth = DateTime(2025, 11);
    _selectedDay = DateTime(2025, 11, 18); // Default to first available day
    
    // Scroll to calendar on initial load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCalendar();
    });
  }

  void _updateScrollButtonVisibility() {
    final threshold = _scrollController.position.maxScrollExtent * 0.5;
    final shouldShow = _scrollController.offset > threshold;
    
    if (shouldShow != _showScrollToCalendarButton) {
      setState(() {
        _showScrollToCalendarButton = shouldShow;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCalendar() {
    // Scroll to bring the calendar section into view
    // Start scrolling to just before the calendar (around 120-150 pixels from top)
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        150,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTimeSlots() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent * 0.7,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  bool _isDateSelectable(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    final status = dayStatus[key] ?? 'available';

    // Can't select past dates, today, closed days, or fully booked days
    return !key.isBefore(DateTime(2025, 11, 18)) &&
        status != 'closed' &&
        status != 'fully_booked' &&
        status != 'unavailable';
  }

  List<DateTime> _getDaysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    return List.generate(
      lastDay.day,
      (index) => DateTime(month.year, month.month, index + 1),
    );
  }

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
                Icons.schedule,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Select Date & Time",
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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// STEP INDICATOR — Step 5 of 5
                  const StepIndicator(
                    currentStep: 5,
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

                  /// Doctor Profile Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Avatar
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.teal[100]!, Colors.teal[50]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.teal[300]!,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              widget.doctorImage,
                              style: const TextStyle(fontSize: 40),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Doctor Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.doctorName,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal[800],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.doctorSpeciality,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 8),
                             
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// Calendar
                  Text(
                    "Select Date",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal[800],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Month/Year Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _currentMonth =
                                      DateTime(_currentMonth.year, _currentMonth.month - 1);
                                });
                              },
                              icon: Icon(Icons.chevron_left,
                                  color: Colors.teal[600]),
                            ),
                            Text(
                              "${_monthName(_currentMonth.month)} ${_currentMonth.year}",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.teal[800],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _currentMonth =
                                      DateTime(_currentMonth.year, _currentMonth.month + 1);
                                });
                              },
                              icon: Icon(Icons.chevron_right,
                                  color: Colors.teal[600]),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Days of Week Header
                        Row(
                          children: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                              .map((day) => Expanded(
                                    child: Text(
                                      day,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                        const SizedBox(height: 12),

                        // Calendar Days
                        _buildCalendarGrid(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// Legend
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildLegendItem("Available", Colors.green[200]!),
                        const SizedBox(width: 16),
                        _buildLegendItem("Fully Booked", Colors.red[200]!),
                        const SizedBox(width: 16),
                        _buildLegendItem("Closed", Colors.grey[400]!),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  /// Time Selection
                  Text(
                    "Select Time",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal[800],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: availableTimeSlots.map((time) {
                      final isSelected = _selectedTime == time;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedTime = time;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.teal[600] : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: isSelected
                                ? null
                                : Border.all(
                                    color: Colors.teal[300]!,
                                    width: 2,
                                  ),
                            boxShadow: [
                              if (isSelected)
                                BoxShadow(
                                  color: Colors.teal.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                            ],
                          ),
                          child: Text(
                            time,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : Colors.teal[700],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Confirm Button
                  _buildConfirmButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: AnimatedOpacity(
        opacity: _showScrollToCalendarButton ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: AnimatedScale(
          scale: _showScrollToCalendarButton ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: FloatingActionButton.small(
            heroTag: null,
            backgroundColor: Colors.teal[600],
            onPressed: _scrollToCalendar,
            child: Icon(
              Icons.arrow_upward,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    final isComplete = _selectedDay.isAfter(DateTime(2025, 11, 17)) &&
        _selectedTime != null;

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isComplete
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingConfirmation(
                        facilityName: widget.facilityName,
                        branchName: widget.branchName,
                        departmentName: widget.departmentName,
                        doctorName: widget.doctorName,
                        doctorImage: widget.doctorImage,
                        doctorSpeciality: widget.doctorSpeciality,
                        selectedDate: _selectedDay,
                        selectedTime: _selectedTime!,
                      ),
                    ),
                  );
                }
              : null,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal[600]!, Colors.teal[400]!],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                  spreadRadius: 1,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: Text(
                "Confirm Appointment",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final days = _getDaysInMonth(_currentMonth);
    final startingDayOfWeek = (DateTime(_currentMonth.year, _currentMonth.month, 1).weekday % 7);

    final List<Widget> dayWidgets = [];

    for (int i = 0; i < startingDayOfWeek; i++) {
      dayWidgets.add(const SizedBox.shrink());
    }

    for (final day in days) {
      final key = DateTime(day.year, day.month, day.day);
      final status = dayStatus[key] ?? 'available';
      final isSelectable = _isDateSelectable(day);
      final isSelected = _selectedDay.year == day.year &&
          _selectedDay.month == day.month &&
          _selectedDay.day == day.day;

      // Determine border color based on status (regardless of selectability)
      Color borderColor = Colors.grey[300]!;
      Color bottomIndicatorColor = Colors.grey[400]!;
      
      if (status == 'available' && isSelectable) {
        borderColor = Colors.green[400]!;
        bottomIndicatorColor = Colors.green[500]!;
      } else if (status == 'fully_booked') {
        borderColor = Colors.red[400]!;
        bottomIndicatorColor = Colors.red[500]!;
      } else if (status == 'closed' || !isSelectable) {
        borderColor = Colors.grey[300]!;
        bottomIndicatorColor = Colors.grey[400]!;
      }

      dayWidgets.add(
        GestureDetector(
          onTap: isSelectable
              ? () {
                  setState(() {
                    _selectedDay = day;
                    _selectedTime = null;
                  });
                  // Scroll to time slots when date is selected
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _scrollToTimeSlots();
                  });
                }
              : null,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected ? Colors.teal[600]! : borderColor,
                width: 2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      )
                    ],
            ),
            child: Stack(
              children: [
                // Day number (top 75%)
                Center(
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      color: isSelectable ? Colors.black87 : Colors.grey[400],
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                ),
                // Bottom colored indicator (25%)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 25,
                    decoration: BoxDecoration(
                      color: bottomIndicatorColor.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 8,
      childAspectRatio: 0.75,
      children: dayWidgets,
    );
  }

  String _monthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }}

/// Step Indicator Widget
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

