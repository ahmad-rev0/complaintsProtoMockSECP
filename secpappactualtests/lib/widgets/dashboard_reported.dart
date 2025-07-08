import 'package:flutter/material.dart';
import 'header_widget.dart';
import 'pills_widget.dart';
import 'complaint_list_widget.dart';
import 'tab_bar_widget.dart';
import 'custom_drawer.dart';

class DashboardReported extends StatefulWidget {
  const DashboardReported({Key? key}) : super(key: key);

  @override
  State<DashboardReported> createState() => _DashboardReportedState();
}

class _DashboardReportedState extends State<DashboardReported> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedPillIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            _buildBackgroundLogo(),
            Column(
              children: [
                HeaderWidget(spacing: 18),
                const SizedBox(height: 10),
                _buildPillNavigation(),
                const SizedBox(height: 12),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ComplaintListWidget(),
                  ),
                ),
              ],
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: TabBarWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundLogo() {
    return Positioned(
      left: 148.29,
      top: -6.4,
      child: Opacity(
        opacity: 0.34,
        child: Image.asset(
          'assets/images/SECP_Logo.png',
          width: 121,
          height: 113,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildPillNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PillsWidget(
        selectedIndex: selectedPillIndex,
        onPillSelected: (index) {
          setState(() => selectedPillIndex = index);
          if (index == 0) {
            Navigator.pushNamed(context, '/report-new');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/chatbot');
          }
        },
      ),
    );
  }
}