import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/pills_widget.dart';

class ReportNewScreen extends StatefulWidget {
  const ReportNewScreen({Key? key}) : super(key: key);

  @override
  State<ReportNewScreen> createState() => _ReportNewScreenState();
}

class _ReportNewScreenState extends State<ReportNewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _cnicController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? selectedSector;
  String? selectedCategory;
  String? selectedNature;
  int selectedPillIndex = 0;
  bool isSubmitting = false;

  @override
  void dispose() {
    _cnicController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.white,
      drawer: const CustomDrawer(),
      appBar: AppBar(
  backgroundColor: const Color(0xFF087A84),
  elevation: 0,
  leading: IconButton(
    icon: const Icon(Icons.menu, color: Colors.white),
    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
  ),
  title: Text(
    'SECP XS Mobile                ',
    style: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontFamily: 'Inter',
      letterSpacing: -0.4,
    ),
  ),
  centerTitle: true, // This centers the title
  actions: [
    IconButton(
      icon: const Icon(Icons.logout, color: Colors.white),
      onPressed: _showLogoutDialog,
    ),
  ],
),
      body: Stack(
        children: [
          // Background logo with opacity
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 57.5,
            top: MediaQuery.of(context).size.height / 2 - 382.9,
            child: Opacity(
              opacity: 0.34,
              child: Image.asset(
                'assets/images/SECP_Logo.png',
                width: 121,
                height: 113,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 12),
                      
                      // Pills Navigation
                      PillsWidget(
                        selectedIndex: selectedPillIndex,
                        onPillSelected: (index) {
                          setState(() => selectedPillIndex = index);
                          if (index == 1) {
                            Navigator.pushNamed(context, '/dashboard');
                          } else if (index == 2) {
                            Navigator.pushNamed(context, '/chatbot');
                          }
                        },
                      ),
                      
                      const SizedBox(height: 10),
                      
                      // Personal/Complainant Information Card
                      _buildSectionCard(
                        title: 'Personal/Complainant Information',
                        children: [
                          const SizedBox(height: 10),
                          CustomInputField(
                            placeholder: 'CNIC',
                            controller: _cnicController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'CNIC is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomInputField(
                            placeholder: 'Mobile Number',
                            controller: _mobileController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Mobile number is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomInputField(
                            placeholder: 'Complainant Email Address',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (!value.contains('@')) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 10),
                      
                      // Complaint/Query Information Title
                      const Text(
                        'Complaint/Query Information',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          fontFamily: 'Inter',
                          height: 1.4,
                        ),
                      ),
                      
                      const SizedBox(height: 5),
                      
                      // Complaint Information Fields
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            _buildDropdownField(
                              label: 'SECTOR',
                              value: selectedSector,
                              onChanged: (value) => setState(() => selectedSector = value),
                            ),
                            _buildDivider(),
                            _buildDropdownField(
                              label: 'CATEGORY',
                              value: selectedCategory,
                              onChanged: (value) => setState(() => selectedCategory = value),
                            ),
                            _buildDivider(),
                            _buildDropdownField(
                              label: 'NATURE OF ISSUE / PROCESS NAME',
                              value: selectedNature,
                              onChanged: (value) => setState(() => selectedNature = value),
                              isLast: true,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 5),
                      
                      // Contextualization Card
                      _buildSectionCard(
                        title: 'Contextualization',
                        children: [
                          const SizedBox(height: 10),
                          CustomInputField(
                            placeholder: 'Subject',
                            controller: _subjectController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Subject is required';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 10),
                          CustomInputField(
                            placeholder: 'Description',
                            controller: _descriptionController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Description is required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 14),
                      
                      // Upload Files Card
                      _buildSectionCard(
                        title: 'Upload Files',
                        children: [
                          const SizedBox(height: 10),
                          CustomButton(
                            text: 'Upload File(2 MB: JPG, JPEG, PNG, PDF)',
                            onPressed: _showFileUploadDialog,
                            height: 65,
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 14),
                      
                      // Terms and Conditions Text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Inter',
                              height: 1.5,
                              color: AppColors.textSecondary,
                            ),
                            children: [
                              TextSpan(text: 'I do '),
                              TextSpan(
                                text: 'hereby solemnly',
                                style: TextStyle(color: AppColors.primary),
                              ),
                              TextSpan(text: ' affirm:That the '),
                              TextSpan(
                                text: 'facts mentioned in this complaint are correct',
                                style: TextStyle(color: AppColors.primary),
                              ),
                              TextSpan(text: ' to the best of my knowledge and belief. That '),
                              TextSpan(
                                text: 'no complaint on this subject has previously been lodged',
                                style: TextStyle(color: AppColors.primary),
                              ),
                              TextSpan(text: ' with the Commission by me, or on my behalf.'),
                            ],
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Submit Button
                      Container(
                        width: 238,
                        height: 55,
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        child: ElevatedButton(
                          onPressed: isSubmitting ? null : _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: isSubmitting
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 26,
                                      height: 26,
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/recaptcha_icon.png',
                                          width: 18,
                                          height: 18,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Inter',
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              fontFamily: 'Inter',
              height: 1.4,
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required Function(String?) onChanged,
    bool isLast = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.success,
                fontFamily: 'Inter',
                height: 1.67,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? 'Select Relevant Option',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: value != null ? AppColors.textPrimary : AppColors.textSecondary,
                      fontFamily: 'Inter',
                      height: 1.4,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _showDropdownOptions(label, onChanged),
                  child: const Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 0.5,
      color: AppColors.border,
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  void _showDropdownOptions(String label, Function(String?) onChanged) {
    List<String> options = [];
    
    switch (label) {
      case 'SECTOR':
        options = ['Banking', 'Insurance', 'Corporate', 'Capital Market', 'Development Finance'];
        break;
      case 'CATEGORY':
        options = ['Consumer Complaint', 'Inquiry', 'Regulatory Matter', 'Technical Issue'];
        break;
      case 'NATURE OF ISSUE / PROCESS NAME':
        options = ['Account Issues', 'Service Quality', 'Fraud', 'Policy Concerns', 'Other'];
        break;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Select $label',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            ...options.map((option) => ListTile(
              title: Text(option),
              onTap: () {
                onChanged(option);
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _showFileUploadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upload File'),
        content: const Text('File upload functionality will be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isSubmitting = true);
      
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() => isSubmitting = false);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complaint submitted successfully!'),
          backgroundColor: AppColors.success,
        ),
      );
      
      Navigator.pop(context);
    }
  }
}