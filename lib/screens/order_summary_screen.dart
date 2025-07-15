import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../utils/responsive_helper.dart';
import '../utils/exception_handler.dart';

class OrderSummaryScreen extends StatelessWidget {
  const OrderSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text('Order Summary', style: AppTextStyles.h5),
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
            Text('Your Order', style: AppTextStyles.h4),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildOrderItem(context, 'Margherita Pizza', 2, 18.99),
                  _buildOrderItem(context, 'Classic Burger', 1, 12.99),
                  _buildOrderItem(context, 'Greek Salad', 1, 11.99),
                ],
              ),
            ),
            const Divider(height: 32),
            _buildSummaryRow('Subtotal', 62.97),
            _buildSummaryRow('Delivery Fee', 2.99),
            _buildSummaryRow('Tax', 1.50),
            const Divider(height: 32),
            _buildSummaryRow('Total', 67.46, isTotal: true),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Place Order'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.surface,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ExceptionHandler.showFeatureNotAvailable(context, 'Place Order');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, String name, int quantity, double price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withAlpha((0.1 * 255).toInt()),
          child: Text(quantity.toString(), style: AppTextStyles.h6),
        ),
        title: Text(name, style: AppTextStyles.bodyMedium),
        trailing: Text('${(price * quantity).toStringAsFixed(2)}', style: AppTextStyles.bodyMedium),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: isTotal ? AppTextStyles.h5 : AppTextStyles.bodyMedium),
          Text('${value.toStringAsFixed(2)}', style: isTotal ? AppTextStyles.priceLarge : AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
} 