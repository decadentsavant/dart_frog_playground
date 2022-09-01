import '../models/food_item.dart';

FoodItem? getMeal(String id) {
  for (var index = 0; index < mealsOfTheDay.length; index++) {
    final currentFoodItem = mealsOfTheDay[index];
    if (currentFoodItem.id == id) {
      return currentFoodItem;
    }
  }
  return null;
}

void createMeal(FoodItem food) {
  mealsOfTheDay.add(food);
}

void updateMeal(String id, FoodItem modifiedFoodItem) {
  for (var index = 0; index < mealsOfTheDay.length; index++) {
    final currentFoodItem = mealsOfTheDay[index];
    if (currentFoodItem.id == id) {
      mealsOfTheDay[index] = modifiedFoodItem;
    }
  }
}

void deleteMeal(String id) {
  for (var index = 0; index < mealsOfTheDay.length; index++) {
    final currentFoodItem = mealsOfTheDay[index];
    if (currentFoodItem.id == id) {
      mealsOfTheDay.removeAt(index);
      break;
    }
  }
}

List<FoodItem> getFoodByCategory(String category) {
  final categoryBasedFoodList = <FoodItem>[];

  for (final foodItem in mealsOfTheDay) {
    if (foodItem.category == category) {
      categoryBasedFoodList.add(foodItem);
    }
  }
  return categoryBasedFoodList;
}
