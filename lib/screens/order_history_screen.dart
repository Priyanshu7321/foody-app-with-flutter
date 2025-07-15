import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../utils/responsive_helper.dart';
import '../utils/exception_handler.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text('Order History', style: AppTextStyles.h5),
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
            _buildOrderCard(context, 'Order #12345', 'Delivered', '2024-01-15', 67.46),
            _buildOrderCard(context, 'Order #12344', 'Delivered', '2024-01-14', 45.99),
            _buildOrderCard(context, 'Order #12343', 'Cancelled', '2024-01-13', 32.50),
            _buildOrderCard(context, 'Order #12342', 'Delivered', '2024-01-12', 28.75),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, String orderId, String status, String date, double total) {
    Color statusColor = status == 'Delivered' ? AppColors.success : AppColors.error;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: ListTile(
        title: Text(orderId, style: AppTextStyles.h6),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(date, style: AppTextStyles.bodySmall),
            Text('Total: \$${total.toStringAsFixed(2)}', style: AppTextStyles.bodyMedium),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withAlpha((0.1 * 255).toInt()),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: AppTextStyles.bodySmall.copyWith(color: statusColor),
          ),
        ),
        onTap: () {
          ExceptionHandler.showFeatureNotAvailable(context, 'View Order Details');
        },
      ),
    );
  }
} 