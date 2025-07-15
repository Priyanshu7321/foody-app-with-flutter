import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../utils/responsive_helper.dart';
import '../utils/exception_handler.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _orderUpdates = true;
  bool _promotions = false;
  bool _deliveryStatus = true;
  bool _newFeatures = true;
  bool _marketing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text('Notifications', style: AppTextStyles.h5),
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
            Text('Notification Settings', style: AppTextStyles.h4),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildNotificationItem(
                    'Order Updates',
                    'Get notified about your order status',
                    _orderUpdates,
                    (value) => setState(() => _orderUpdates = value),
                  ),
                  _buildNotificationItem(
                    'Promotions & Offers',
                    'Receive special offers and discounts',
                    _promotions,
                    (value) => setState(() => _promotions = value),
                  ),
                  _buildNotificationItem(
                    'Delivery Status',
                    'Track your food delivery in real-time',
                    _deliveryStatus,
                    (value) => setState(() => _deliveryStatus = value),
                  ),
                  _buildNotificationItem(
                    'New Features',
                    'Learn about new app features',
                    _newFeatures,
                    (value) => setState(() => _newFeatures = value),
                  ),
                  _buildNotificationItem(
                    'Marketing',
                    'Receive marketing communications',
                    _marketing,
                    (value) => setState(() => _marketing = value),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.surface,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Save Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: ListTile(
        leading: Icon(
          title == 'Order Updates' ? Icons.shopping_bag :
          title == 'Promotions & Offers' ? Icons.local_offer :
          title == 'Delivery Status' ? Icons.delivery_dining :
          title == 'New Features' ? Icons.new_releases :
          Icons.campaign, // TODO: Use custom Marketing icon
          color: AppColors.primary,
        ),
        title: Text(title, style: AppTextStyles.h6),
        subtitle: Text(subtitle, style: AppTextStyles.bodySmall),
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
        ),
      ),
    );
  }

  void _saveSettings() {
    ExceptionHandler.showFeatureNotAvailable(context, 'Save Notification Settings');
  }
} 