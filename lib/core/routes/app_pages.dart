import 'package:get/get.dart';
import '../../screens/onboarding_screen.dart';
import '../../screens/auth_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/food_detail_screen.dart';
import '../../screens/search_screen.dart';
import '../../screens/cart_screen.dart';
import '../../screens/profile_screen.dart';
import '../../screens/favorites_screen.dart';
import '../../screens/order_confirmation_screen.dart';
import '../../screens/order_summary_screen.dart';
import '../../screens/order_tracking_screen.dart';
import '../../screens/payment_status_screen.dart';
import '../../screens/settings_screen.dart';
import '../../screens/order_history_screen.dart';
import '../../screens/payment_methods_screen.dart';
import '../../screens/add_address_screen.dart';
import '../../screens/edit_profile_screen.dart';
import '../../screens/notifications_screen.dart';
import '../../screens/help_support_screen.dart';
import '../../screens/about_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    // Onboarding and Authentication
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: AppRoutes.auth,
      page: () => const AuthScreen(),
    ),
    
    // Main App Screens
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.foodDetail,
      page: () => const FoodDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.search,
      page: () => const SearchScreen(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartScreen(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => const FavoritesScreen(),
    ),
    
    // Order and Payment
    GetPage(
      name: AppRoutes.orderConfirmation,
      page: () => const OrderConfirmationScreen(),
    ),
    GetPage(
      name: AppRoutes.orderSummary,
      page: () => const OrderSummaryScreen(),
    ),
    GetPage(
      name: AppRoutes.orderTracking,
      page: () => const OrderTrackingScreen(),
    ),
    GetPage(
      name: AppRoutes.paymentStatus,
      page: () => const PaymentStatusScreen(),
    ),
    
    // Profile Related
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: AppRoutes.orderHistory,
      page: () => const OrderHistoryScreen(),
    ),
    GetPage(
      name: AppRoutes.paymentMethods,
      page: () => const PaymentMethodsScreen(),
    ),
    GetPage(
      name: AppRoutes.addresses,
      page: () => const AddAddressScreen(),
    ),
    GetPage(
      name: AppRoutes.addAddress,
      page: () => const AddAddressScreen(),
    ),
    GetPage(
      name: AppRoutes.editProfile,
      page: () => const EditProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationsScreen(),
    ),
    GetPage(
      name: AppRoutes.helpSupport,
      page: () => const HelpSupportScreen(),
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => const AboutScreen(),
    ),
  ];
} 