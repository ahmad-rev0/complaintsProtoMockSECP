import 'package:flutter/material.dart';
import 'screens/sign_in_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/report_new_screen.dart';
import 'screens/complaint_detail_screen.dart';
import 'screens/complaint_detail_closed_screen.dart';
import 'screens/chatbot_screen.dart';

void main() {
  runApp(const SECPMobileApp());
}

class SECPMobileApp extends StatelessWidget {
  const SECPMobileApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SECP Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: const Color(0xFF087A84),
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF087A84),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF087A84),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF087A84),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
  '/': (context) => const SignInScreen(),
  '/dashboard': (context) => const DashboardScreen(),
  '/report-new': (context) => const ReportNewScreen(),
  '/chatbot': (context) => const ChatbotScreen(),
  '/complaint-detail': (context) {
    // Get arguments passed via Navigator.pushNamed
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return ComplaintDetailScreen(
      complaintNumber: args['complaintNumber'],
      status: args['status'],
      area: args['area'],
      date: args['date'],
      companyName: args['companyName'],
      statusColor: args['statusColor'],
    );
  },
  '/complaint-detail-closed': (context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return ComplaintDetailClosedScreen(
      complaintNumber: args['complaintNumber'],
      area: args['area'],
      date: args['date'],
      companyName: args['companyName'],
      rating: args['rating'] ?? 0,
      correspondence: args['correspondence'] ?? const [],
    );
  },
},
    );
  }
}