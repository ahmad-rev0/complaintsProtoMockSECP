import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/pills_widget.dart';

class ComplaintDetailClosedScreen extends StatefulWidget {
  final String complaintNumber;
  final String area;
  final String date;
  final String companyName;
  final int rating;
  final List<Map<String, dynamic>> correspondence;

  const ComplaintDetailClosedScreen({
    Key? key,
    required this.complaintNumber,
    required this.area,
    required this.date,
    required this.companyName,
    this.rating = 0,
    this.correspondence = const [],
  }) : super(key: key);

  @override
  State<ComplaintDetailClosedScreen> createState() => _ComplaintDetailClosedScreenState();
}

class _ComplaintDetailClosedScreenState extends State<ComplaintDetailClosedScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int selectedPillIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: const CustomDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/images/back_icon.png',
            width: 24,
            height: 24,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Complaint Details',
          style: AppTextStyles.appTitle.copyWith(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            _buildBackgroundLogo(),
            Column(
              children: [
                _buildPillNavigation(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        _buildTitle(),
                        const SizedBox(height: 8),
                        _buildSubtitle(),
                        const SizedBox(height: 24),
                        _buildCommentsSection(),
                        const SizedBox(height: 24),
                        _buildOverviewSection(),
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _buildTabBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundLogo() {
    return Positioned(
      left: 272,
      top: 25,
      child: Opacity(
        opacity: 0.1,
        child: Image.asset(
          'assets/images/SECP_Logo.png',
          width: 150,
          height: 140,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 150,
              height: 140,
              color: AppColors.border.withOpacity(0.1),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPillNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 12, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildPill('Report New', false, () {
            Navigator.pushNamed(context, '/report-new');
          }),
          const SizedBox(width: 8),
          _buildPill('Reported', false, () {
            Navigator.pushNamed(context, '/dashboard');
          }),
          const SizedBox(width: 8),
          _buildPill('Chatbot', false, () {
            Navigator.pushNamed(context, '/chatbot');
          }),
        ],
      ),
    );
  }

  Widget _buildPill(String text, bool isSelected, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 6.5),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.buttonSecondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textPrimary,
            fontFamily: 'Inter',
            height: 1.4,
          ),
        ),
      ),
    );
  }

  // ... [Rest of your existing methods remain the same] ...


  Widget _buildTitle() {
    return Text(
      'Reported Complaint Expanded',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
        fontFamily: 'Inter',
        height: 1.4,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      '${widget.complaintNumber} | ${widget.area} | ${widget.date}',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryLight,
        fontFamily: 'Inter',
        height: 1.4,
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Comments header with icon
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.success,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/comment_icon.png',
                      width: 24,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.chat_bubble,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.success,
                          fontFamily: 'Inter',
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Complaint Number: ${widget.complaintNumber}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                          fontFamily: 'Inter',
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Closed complaint message
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.error.withOpacity(0.5)),
              color: Colors.white,
            ),
            child: Text(
              'Commenting only available for open complaints',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.error,
                fontFamily: 'Inter',
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Rating section
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Text(
                  'Rating',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                    fontFamily: 'Inter',
                    height: 1.4,
                  ),
                ),
                const SizedBox(width: 16),
                Row(
                  children: List.generate(5, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.asset(
                        'assets/images/star_icon.png',
                        width: 24,
                        height: 24,
                        color: index < widget.rating 
                            ? AppColors.success 
                            : AppColors.textSecondary,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.star,
                          color: index < widget.rating 
                              ? AppColors.success 
                              : AppColors.textSecondary,
                          size: 24,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Overview header with icon
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/overview_icon.png',
                      width: 24,
                      height: 24,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.visibility,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Overview Section',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                    fontFamily: 'Inter',
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          // Complainant Details
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Complainant Details',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                fontFamily: 'Inter',
                height: 1.4,
              ),
            ),
          ),
          _buildInfoField('Email: testMail@test.com'),
          _buildInfoField('Date of Complaint: ${widget.date}'),
          // Complaint Details
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Complaint Details',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                fontFamily: 'Inter',
                height: 1.4,
              ),
            ),
          ),
          _buildInfoField('Subject: test'),
          _buildInfoField('Nature of Issue: Miscellaneous'),
          _buildInfoField('Process Ref #: 0000'),
          // Correspondence
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Correspondence',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                fontFamily: 'Inter',
                height: 1.4,
              ),
            ),
          ),
          // Correspondence messages
          ..._buildCorrespondenceMessages(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  List<Widget> _buildCorrespondenceMessages() {
    return widget.correspondence.map((message) {
      bool isOfficer = message['type'] == 'officer';
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              isOfficer 
                ? 'assets/images/officer_icon.png' 
                : 'assets/images/user_icon.png',
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) => Icon(
                isOfficer ? Icons.person : Icons.person_outline,
                color: AppColors.primary,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${isOfficer ? 'Officer' : 'Complainant'}: ${message['text']}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimary,
                  fontFamily: 'Inter',
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildInfoField(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.textPrimary,
          fontFamily: 'Inter',
          height: 1.4,
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              'Closed',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFamily: 'Inter',
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}