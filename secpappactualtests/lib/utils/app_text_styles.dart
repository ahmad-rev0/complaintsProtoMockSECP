import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // App Title
  static const TextStyle appTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    fontFamily: 'Inter',
    letterSpacing: -0.48,
    height: 1.4,
  );

  // Section Titles
  static const TextStyle sectionTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
    height: 1.4,
  );

  // Section Subtitles
  static const TextStyle sectionSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamily: 'Inter',
    height: 1.5,
  );

  // Button Text
  static const TextStyle buttonPrimary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
    fontFamily: 'Inter',
    height: 1.4,
  );

  static const TextStyle buttonSecondary = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
    height: 1.4,
  );

  // Input Text
  static const TextStyle inputText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    fontFamily: 'Inter',
    height: 1.4,
  );

  static const TextStyle inputPlaceholder = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamily: 'Inter',
    height: 1.4,
  );

  // Terms Text
  static const TextStyle termsText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter',
    height: 1.5,
  );

  // Divider Text
  static const TextStyle dividerText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    fontFamily: 'Inter',
    height: 1.4,
  );
}
