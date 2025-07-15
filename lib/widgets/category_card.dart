import 'package:flutter/material.dart';
import '../models/category.dart';
import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../utils/responsive_helper.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final VoidCallback? onTap;
  final bool isSelected;

  const CategoryCard({
    super.key,
    required this.category,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ResponsiveHelper.isMobile(context) ? 100 : 120,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Category Icon
            Container(
              width: ResponsiveHelper.isMobile(context) ? 40 : 50,
              height: ResponsiveHelper.isMobile(context) ? 40 : 50,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.surface : AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  category.icon,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.isMobile(context) ? 20 : 24,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            
            // Category Name
            Text(
              category.name,
              style: AppTextStyles.category.copyWith(
                color: isSelected ? AppColors.surface : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            // Item Count
            Text(
              '${category.itemCount} items',
              style: AppTextStyles.caption.copyWith(
                color: isSelected ? AppColors.surface.withAlpha((0.8 * 255).toInt()) : AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 