import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/product.dart';
import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../utils/responsive_helper.dart';

class FoodCard extends StatelessWidget {
  final Product food;
  final VoidCallback? onTap;
  final bool showRating;

  const FoodCard({
    super.key,
    required this.food,
    this.onTap,
    this.showRating = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                food.imageUrl,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),

            // Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Title
                    Text(
                      food.name,
                      style: AppTextStyles.h6,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    // Desc
                    Text(
                      food.description,
                      style: AppTextStyles.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),

                    // Rating + price (Flexible row)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showRating)
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: food.rating,
                                itemBuilder: (_, __) =>
                                const Icon(Icons.star, color: AppColors.rating),
                                itemCount: 5,
                                itemSize: 14,

                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${food.reviewCount})',
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),

                        Text(
                          '\$${food.price.toStringAsFixed(2)}',
                          style: AppTextStyles.priceMedium,
                        ),
                      ],
                    ),

                    const Spacer(), // <-- THIS fixes overflow elegantly

                    // Time row
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text('${food.preparationTime} min',
                            style: AppTextStyles.caption),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
