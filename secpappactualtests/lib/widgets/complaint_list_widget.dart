import 'package:flutter/material.dart';
import 'complaint_cell_widget.dart';

class ComplaintListWidget extends StatelessWidget {
  const ComplaintListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final complaints = [
      {
        'ticketInfo': '14578 | Other SECP Apps | 03-07-2025',
        'companyName': 'GREEN KHYBER CROP SCIENCES (PRIVATE) LIMITED ~(0209664)',
        'avatarUrl': null,
        'avatarColor': const Color(0xFFDC3033),
      },
      {
        'ticketInfo': '14577 | General Queries | 03-07-2025',
        'companyName': 'AAGENS SOLAR SYSTEMS PAKISTAN (PRIVATE) LIMITED ~(0065538)',
        'avatarUrl': null,
        'avatarColor': const Color (0xFFE3CB2F),
      },
      {
        'ticketInfo': '14576 | Islamic Finance | 03-07-2025',
        'companyName': 'ALMEEZAN (PVT.) LIMITED ~(0050691)',
        'avatarUrl': null,
        'avatarColor': const Color(0xFF6BAC48),
      },
      {
        'ticketInfo': '14575 | Insurance | 03-07-2025',
        'companyName': '12 GATES (PVT.) LIMITED ~(0089536)',
        'avatarUrl': null,
        'avatarColor': const Color(0xFF6BAC48),
      },
      {
        'ticketInfo': '14574 | Capital Market | 03-07-2025',
        'companyName': '100 CARE TESTING SERVICES (PRIVATE) LIMITED ~(0079407)',
        'avatarUrl': null,
        'avatarColor': const Color(0xFF6BAC48),
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reported Complaints',
                  style: TextStyle(
                    color: Color(0xFF087A84),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  child: const Text(
                    '            Ticket        |              Area              |        Date',
                    style: TextStyle(
                      color: Color(0xFF087A84),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                      height: 1.4,
                      shadows: [
                        Shadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0, 4),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // List
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: complaints.length,
                itemBuilder: (context, index) {
                  final complaint = complaints[index];
                  return ComplaintCellWidget(
                    ticketInfo: complaint['ticketInfo'] as String,
                    companyName: complaint['companyName'] as String,
                    avatarUrl: complaint['avatarUrl'] as String?,
                    avatarColor: complaint['avatarColor'] as Color?,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
