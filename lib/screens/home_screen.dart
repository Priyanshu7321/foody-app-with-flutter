import 'package:flutter/material.dart';
import 'package:foody/screens/components/LiquidBarExample.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../utils/responsive_helper.dart';
import '../widgets/food_card.dart';
import '../viewmodels/product_viewmodel.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../core/routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductViewModel _productViewModel = Get.find<ProductViewModel>();
  final CartViewModel _cartViewModel = Get.find<CartViewModel>();

  @override
  void initState() {
    super.initState();
    _productViewModel.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              backgroundColor: AppColors.categoryColors[4],
              elevation: 0,
              floating: true,
              pinned: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: AppColors.categoryColors[4],
                  child: Padding(
                    padding: ResponsiveHelper.getResponsivePadding(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deliver to',
                                    style: AppTextStyles.caption.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: AppColors.primary,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Home',
                                        style: AppTextStyles.bodyMedium.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppColors.textSecondary,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Cart Icon with Badge
                            Stack(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.cart);
                                  },
                                  icon: const Icon(
                                    Icons.shopping_cart_outlined,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Obx(() {
                                  if (_cartViewModel.itemCount > 0) {
                                    return Positioned(
                                      right: 8,
                                      top: 8,
                                      child: Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 16,
                                          minHeight: 16,
                                        ),
                                        child: Text(
                                          _cartViewModel.itemCount.toString(),
                                          style: AppTextStyles.caption.copyWith(
                                            color: AppColors.surface,
                                            fontSize: 10,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                }),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Search Bar
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.search);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Search for food, restaurants...',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            
            // Categories
            SliverToBoxAdapter(
              child: Container(
                padding:EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: AppTextStyles.h5,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          final categories = [
                            {'name': 'Pizza', 'icon': '🍕'},
                            {'name': 'Burgers', 'icon': '🍔'},
                            {'name': 'Sushi', 'icon': '🍣'},
                            {'name': 'Pasta', 'icon': '🍝'},
                            {'name': 'Salads', 'icon': '🥗'},
                            {'name': 'Desserts', 'icon': '🍰'},
                          ];
                          
                          final category = categories[index];
                          return Container(
                            width: 80,
                            margin: const EdgeInsets.only(right: 2),
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: AppColors.surface,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppColors.border),
                                  ),
                                  child: Center(
                                    child: Text(
                                      category['icon']!,
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category['name']!,
                                  style: AppTextStyles.caption,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Popular Foods
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Popular Foods',
                          style: AppTextStyles.h5,
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Navigate to all popular foods
                          },
                          child: Text(
                            'See All',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Obx(() {
                      if (_productViewModel.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      
                      final popularFoods = _productViewModel.products
                          .where((food) => food.isPopular)
                          .take(4)
                          .toList();
                      
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : 4,
                          childAspectRatio: 0.55,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: popularFoods.length,
                        itemBuilder: (context, index) {
                          final food = popularFoods[index];
                          return FoodCard(
                            food: food,
                            onTap: () {
                              Get.toNamed(AppRoutes.foodDetail, arguments: food);
                            },
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
            
            // New Foods
            SliverToBoxAdapter(
              child: Container(
                padding: ResponsiveHelper.getResponsivePadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'New Arrivals',
                          style: AppTextStyles.h5,
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Navigate to all new foods
                          },
                          child: Text(
                            'See All',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),
                    Obx(() {
                      final newFoods = _productViewModel.products
                          .where((food) => food.isNew)
                          .take(4)
                          .toList();
                      
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: ResponsiveHelper.isMobile(context) ? 2 : 4,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: newFoods.length,
                        itemBuilder: (context, index) {
                          final food = newFoods[index];
                          return FoodCard(
                            food: food,
                            onTap: () {
                              Get.toNamed(AppRoutes.foodDetail, arguments: food);
                            },
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),

            // Bottom padding
            const SliverToBoxAdapter(
              child: SizedBox(height: 32),
            ),
          ],
        ),

      ),
          Positioned.fill(
            child: Center(
              child: BottomBar(currentIndex: 0, onTap: (t){}),
            ),
          ),
      ],
      ),
    );
  }
} 