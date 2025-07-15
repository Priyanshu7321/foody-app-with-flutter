import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../utils/responsive_helper.dart';
import '../utils/exception_handler.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text('Help & Support', style: AppTextStyles.h5),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('How can we help you?', style: AppTextStyles.h4),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildHelpItem(
                    context,
                    'FAQ',
                    'Frequently asked questions',
                    Icons.question_answer,
                  ),
                  _buildHelpItem(
                    context,
                    'Contact Support',
                    'Get in touch with our team',
                    Icons.support_agent,
                  ),
                  _buildHelpItem(
                    context,
                    'Order Issues',
                    'Report problems with your order',
                    Icons.report_problem,
                  ),
                  _buildHelpItem(
                    context,
                    'Payment Help',
                    'Payment and billing support',
                    Icons.payment,
                  ),
                  _buildHelpItem(
                    context,
                    'App Feedback',
                    'Share your thoughts with us',
                    Icons.feedback,
                  ),
                  _buildHelpItem(
                    context,
                    'Privacy Policy',
                    'Read our privacy policy',
                    Icons.privacy_tip,
                  ),
                  _buildHelpItem(
                    context,
                    'Terms of Service',
                    'Read our terms of service',
                    Icons.description,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.email),
                label: const Text('Email Support'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ExceptionHandler.showFeatureNotAvailable(context, 'Email Support');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem(BuildContext context, String title, String subtitle, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title, style: AppTextStyles.h6),
        subtitle: Text(subtitle, style: AppTextStyles.bodySmall),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
        onTap: () {
          ExceptionHandler.showFeatureNotAvailable(context, title);
        },
      ),
    );
  }
} 