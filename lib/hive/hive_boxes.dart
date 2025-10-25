import 'package:hive/hive.dart';

import '../components/export_files.dart';

class HiveBoxes {
  static Box<Recipe> getAllRecipeBox() => Hive.box<Recipe>('allRecipesBox');
  static Box<dynamic> getFavouriteIdBox() =>
      Hive.box<dynamic>('favouriteIdBox');
  static Box<MealPlan> getMealPlanBox() => Hive.box<MealPlan>('mealPlans');
}
