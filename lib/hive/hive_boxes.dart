import 'package:hive/hive.dart';

import '../models/meal_plan.dart';
import '../models/recipe.dart';

class HiveBoxes {
  static Box<Recipe> getAllRecipeBox() => Hive.box<Recipe>('allRecipesBox');
  static Box<Recipe> getFavouriteBox() => Hive.box<Recipe>('favouriteBox');
  static Box<MealPlan> getMealPlanBox() => Hive.box<MealPlan>('mealPlans');
}
