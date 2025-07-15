import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  // Example observable
  var selectedCategoryIndex = 0.obs;

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  // Add more business logic and state here
} 