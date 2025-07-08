import 'package:flutter/material.dart';
import '../screens/complaint_detail_screen.dart';
import '../screens/complaint_detail_closed_screen.dart';

class ComplaintCellWidget extends StatelessWidget {
  final String ticketInfo;
  final String companyName;
  final String? avatarUrl;
  final Color? avatarColor;

  const ComplaintCellWidget({
    Key? key,
    required this.ticketInfo,
    required this.companyName,
    this.avatarUrl,
    this.avatarColor,
  }) : super(key: key);

  String _getStatus() {
    if (avatarColor == const Color(0xFFE3CB2F)) {
      return 'assigned';
    } else if (avatarColor == const Color(0xFFDC3033)) {
      return 'unassigned';
    } else if (avatarColor == const Color(0xFF6BAC48)) {
      return 'closed';
    }
    return 'unassigned';
  }

  Map<String, String> _parseTicketInfo() {
    final parts = ticketInfo.split(' | ');
    return {
      'number': parts.isNotEmpty ? parts[0] : '',
      'area': parts.length > 1 ? parts[1] : '',
      'date': parts.length > 2 ? parts[2] : '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final ticketData = _parseTicketInfo();
        final status = _getStatus();

        if (status == 'closed') {
          // Navigate to closed complaint screen with sample correspondence
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComplaintDetailClosedScreen(
                complaintNumber: ticketData['number']!,
                area: ticketData['area']!,
                date: ticketData['date']!,
                companyName: companyName,
                rating: 3, // Sample rating
                correspondence: [
                  {
                    'type': 'officer',
                    'text': 'Kindly upload supporting documents.',
                  },
                  {
                    'type': 'complainant',
                    'text': 'Documents uploaded.',
                  },
                ],
              ),
            ),
          );
        } else if (status == 'assigned' || status == 'unassigned') {
          // Navigate to regular complaint detail screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ComplaintDetailScreen(
                complaintNumber: ticketData['number']!,
                status: status,
                area: ticketData['area']!,
                date: ticketData['date']!,
                companyName: companyName,
                statusColor: avatarColor ?? const Color(0xFFDC3033),
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: avatarColor ?? const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: avatarUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        avatarUrl!,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: avatarColor ?? const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: avatarColor ?? const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ticket Info
                  Text(
                    ticketInfo,
                    style: const TextStyle(
                      color: Color(0xFF087A84),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Company Name
                  Text(
                    companyName,
                    style: const TextStyle(
                      color: Color(0xFF828282),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Inter',
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}