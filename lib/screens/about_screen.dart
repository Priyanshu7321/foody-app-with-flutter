import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../utils/responsive_helper.dart';
import '../utils/exception_handler.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text('About', style: AppTextStyles.h5),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: ResponsiveHelper.getResponsivePadding(context),
        child: Column(
          children: [
            const SizedBox(height: 32),
            CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.restaurant, size: 60, color: AppColors.surface),
            ),
            const SizedBox(height: 24),
            Text('Foody', style: AppTextStyles.h2),
            const SizedBox(height: 8),
            Text('Version 1.0.0', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary)),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  _buildAboutItem(
                    context,
                    'App Description',
                    'Foody is your ultimate food delivery companion. Order delicious meals from your favorite restaurants and get them delivered right to your doorstep.',
                  ),
                  _buildAboutItem(
                    context,
                    'Features',
                    '• Easy food ordering\n• Real-time delivery tracking\n• Multiple payment options\n• Order history\n• Favorite restaurants',
                  ),
                  _buildAboutItem(
                    context,
                    'Contact',
                    'Email: support@foody.com\nPhone: +1 234 567 8900\nWebsite: www.foody.com',
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSocialButton(context, Icons.facebook, 'Facebook'),
                      _buildSocialButton(context, Icons.alternate_email, 'Twitter'), // TODO: Use custom Twitter icon
                      _buildSocialButton(context, Icons.camera_alt, 'Instagram'), // TODO: Use custom Instagram icon
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  ExceptionHandler.showFeatureNotAvailable(context, 'Rate App');
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Rate App'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutItem(BuildContext context, String title, String content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.h6),
            const SizedBox(height: 8),
            Text(content, style: AppTextStyles.bodyMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            ExceptionHandler.showFeatureNotAvailable(context, label);
          },
          icon: Icon(icon, color: AppColors.primary, size: 32),
        ),
        Text(label, style: AppTextStyles.caption),
      ],
    );
  }
} 