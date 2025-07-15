import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../utils/responsive_helper.dart';
import '../utils/exception_handler.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text('Settings', style: AppTextStyles.h5),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: ResponsiveHelper.getResponsivePadding(context),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.notifications, color: AppColors.primary),
              title: const Text('Notifications'),
              trailing: Switch(value: true, onChanged: (v) {}),
            ),
            ListTile(
              leading: const Icon(Icons.language, color: AppColors.primary),
              title: const Text('Language'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ExceptionHandler.showFeatureNotAvailable(context, 'Change Language');
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock, color: AppColors.primary),
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ExceptionHandler.showFeatureNotAvailable(context, 'Privacy Policy');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info, color: AppColors.primary),
              title: const Text('About'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                ExceptionHandler.showFeatureNotAvailable(context, 'About');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.error),
              title: const Text('Logout'),
              onTap: () {
                ExceptionHandler.showFeatureNotAvailable(context, 'Logout');
              },
            ),
          ],
        ),
      ),
    );
  }
} 