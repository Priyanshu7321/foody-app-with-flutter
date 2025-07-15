import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../utils/responsive_helper.dart';
import '../utils/exception_handler.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text('Delivery Address', style: AppTextStyles.h5),
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
            Text('Your Addresses', style: AppTextStyles.h4),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildAddressCard(context, 'Home', '123 Main Street, City, Country', true),
                  _buildAddressCard(context, 'Work', '456 Office Park, City, Country', false),
                  _buildAddressCard(context, 'Other', '789 Other Place, City, Country', false),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_location_alt),
                label: const Text('Add New Address'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.surface,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ExceptionHandler.showFeatureNotAvailable(context, 'Add Address');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, String label, String address, bool isSelected) {
    return Card(
      color: isSelected ? AppColors.primary.withAlpha((0.1 * 255).toInt()) : AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: 2,
        ),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(
          isSelected ? Icons.check_circle : Icons.location_on,
          color: isSelected ? AppColors.primary : AppColors.textSecondary,
        ),
        title: Text(label, style: AppTextStyles.h6),
        subtitle: Text(address, style: AppTextStyles.bodySmall),
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: AppColors.textSecondary),
          onPressed: () {
            ExceptionHandler.showFeatureNotAvailable(context, 'Edit Address');
          },
        ),
        onTap: () {
          ExceptionHandler.showFeatureNotAvailable(context, 'Select Address');
        },
      ),
    );
  }
} 