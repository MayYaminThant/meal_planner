import 'package:hive_flutter/hive_flutter.dart';

import '../components/export_files.dart';

class HiveService {
  static const String recipesBoxName = 'allRecipesBox';
  static const String favouriteRecipes = 'favouriteBox';
  static const String mealPlans = 'mealPlans';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(RecipeAdapter());
    Hive.registerAdapter(MealPlanAdapter());

    await Hive.openBox<Recipe>(recipesBoxName);
    await Hive.openBox<Recipe>(favouriteRecipes);
    await Hive.openBox<MealPlan>(mealPlans);
  }
}
