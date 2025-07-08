import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/social_login_button.dart';
import '../widgets/divider_with_text.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  bool _isSocialLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate authentication process
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // Navigate to dashboard
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/dashboard');
    }
  }

  Future<void> _handleSocialLogin() async {
    setState(() {
      _isSocialLoading = true;
    });

    // Simulate social login process
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isSocialLoading = false;
    });

    // Navigate to dashboard
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth <= 640;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(
              minHeight: screenHeight - MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                // Status Bar Space
                const SizedBox(height: 44),

                // App Title
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 20 : 0,
                  ),
                  child: const Text(
                    'SECP XS Mobile',
                    style: AppTextStyles.appTitle,
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 29),

                // Logo
                Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/SECP_Logo.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 128,
                          height: 128,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.security,
                            color: AppColors.white,
                            size: 64,
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: isSmallScreen ? 38 : 0),

                // Content Section
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 24 : 32,
                  ),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      children: [
                        // Copy Section
                        const Column(
                          children: [
                            Text(
                              'Register | Sign in',
                              style: AppTextStyles.sectionTitle,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Enter login/sign up email',
                              style: AppTextStyles.sectionSubtitle,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Input and Button Section
                        Column(
                          children: [
                            CustomInputField(
                              placeholder: 'email@domain.com',
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              text: 'Continue',
                              isLoading: _isLoading,
                              onPressed: (_isLoading || _isSocialLoading) ? null : _handleContinue,
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Divider
                        const DividerWithText(text: 'or'),

                        const SizedBox(height: 24),

                        // Social Login Button
                        SocialLoginButton(
                          text: 'Continue with eZfile',
                          iconAsset: 'assets/images/ezfile_logo.png',
                          isLoading: _isSocialLoading,
                          onPressed: (_isLoading || _isSocialLoading) ? null : _handleSocialLogin,
                        ),

                        SizedBox(height: isSmallScreen ? 36 : 24),

                        // Terms and Privacy Policy
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: AppTextStyles.termsText.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            children: [
                              const TextSpan(
                                text: 'By clicking continue, you agree to our',
                              ),
                              TextSpan(
                                text: '\nTerms of Service ',
                                style: AppTextStyles.termsText.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                              const TextSpan(
                                text: 'and',
                              ),
                              TextSpan(
                                text: ' Privacy Policy',
                                style: AppTextStyles.termsText.copyWith(
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
