import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isContactUsExpanded = false;

  // Contact information - you can modify these
  final String whatsappNumber = "+923267779999"; // Your WhatsApp number
  final String instagramUrl = "https://www.instagram.com/explore/locations/1009508365865017/securities-and-exchange-commission-of-pakistan-secp/"; // Your Instagram
  final String phoneNumber = "+9251111117327"; // Your phone number
  final String emailAddress = "complaints@secp.gov.pk"; // Your email

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            _buildDrawerHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 20),
                  _buildContactUsSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 Widget _buildDrawerHeader() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: AppColors.primary,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 4,
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Image.asset(
              'assets/images/SECP_Logo.png', // Your custom PNG path
              width: 35,
              height: 35,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.business, // Fallback icon if image fails to load
                color: AppColors.primary,
                size: 45,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SECP XS Mobile',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Securities & Exchange Commission',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.9),
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildContactUsSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isContactUsExpanded = !isContactUsExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.buttonSecondary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.contact_support,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
                Icon(
                  isContactUsExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppColors.primary,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        if (isContactUsExpanded) ...[
          const SizedBox(height: 8),
          _buildContactOptions(),
        ],
      ],
    );
  }

  Widget _buildContactOptions() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          _buildContactOption(
            icon: Icons.phone,
            label: 'WhatsApp',
            onTap: _openWhatsApp,
            iconColor: const Color(0xFF25D366),
          ),
          const SizedBox(height: 12),
          _buildContactOption(
            icon: Icons.camera_alt,
            label: 'Instagram',
            onTap: _openInstagram,
            iconColor: const Color(0xFFE4405F),
          ),
          const SizedBox(height: 12),
          _buildContactOption(
            icon: Icons.call,
            label: 'Phone Call',
            onTap: _makePhoneCall,
            iconColor: const Color(0xFF4CAF50),
          ),
          const SizedBox(height: 12),
          _buildContactOption(
            icon: Icons.email,
            label: 'Email',
            onTap: _sendEmail,
            iconColor: const Color(0xFF2196F3),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required Color iconColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.buttonSecondary,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openWhatsApp() async {
    final url = Uri.parse('https://wa.me/$whatsappNumber');
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      _showErrorSnackBar('Could not open WhatsApp');
    }
  }

  Future<void> _openInstagram() async {
    final url = Uri.parse(instagramUrl);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      _showErrorSnackBar('Could not open Instagram');
    }
  }

  Future<void> _makePhoneCall() async {
    final url = Uri.parse('tel:$phoneNumber');
    try {
      await launchUrl(url);
    } catch (e) {
      _showErrorSnackBar('Could not make phone call');
    }
  }

  Future<void> _sendEmail() async {
    final url = Uri.parse('mailto:$emailAddress');
    try {
      await launchUrl(url);
    } catch (e) {
      _showErrorSnackBar('Could not open email app');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
      ),
    );
  }
}
