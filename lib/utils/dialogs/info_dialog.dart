import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

Future<void> showInfoDialog(BuildContext context, {
  required String title,
  required String message,
  String buttonText = 'OK',
  IconData? icon,
}) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface.withAlpha((0.95 * 255).toInt()),
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon ?? Icons.info_outline,
                  color: AppColors.info,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(title, style: AppTextStyles.h5, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: AppTextStyles.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.info,
                      foregroundColor: AppColors.surface,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
} 