import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../utils/responsive_helper.dart';
import '../utils/exception_handler.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text('Track Order', style: AppTextStyles.h5),
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
            Text('Order Status', style: AppTextStyles.h4),
            const SizedBox(height: 24),
            _buildStatusStep(context, 'Order Placed', true),
            _buildStatusStep(context, 'Preparing Food', true),
            _buildStatusStep(context, 'Out for Delivery', false),
            _buildStatusStep(context, 'Delivered', false),
            const SizedBox(height: 32),
            Center(
              child: Column(
                children: [
                  const Icon(Icons.delivery_dining, color: AppColors.primary, size: 64),
                  const SizedBox(height: 16),
                  Text('Your food is being prepared!', style: AppTextStyles.h5, textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  Text('Estimated delivery: 30 min', style: AppTextStyles.bodyMedium),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                child: const Text('Contact Support'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ExceptionHandler.showFeatureNotAvailable(context, 'Contact Support');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusStep(BuildContext context, String label, bool isCompleted) {
    return Row(
      children: [
        Icon(
          isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isCompleted ? AppColors.success : AppColors.textLight,
        ),
        const SizedBox(width: 12),
        Text(label, style: AppTextStyles.bodyMedium),
      ],
    );
  }
} 