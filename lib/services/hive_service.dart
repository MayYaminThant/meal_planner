import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_planner/models/step.dart';

import '../components/export_files.dart';

class HiveService {
  static const String recipesBoxName = 'allRecipesBox';
  static const String favouriteRecipes = 'favouriteIdBox';
  static const String mealPlans = 'mealPlans';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(RecipeAdapter());
    Hive.registerAdapter(MealPlanAdapter());
    Hive.registerAdapter(AnalyzedInstructionAdapter());
    Hive.registerAdapter(EntAdapter());
    Hive.registerAdapter(IngredientAdapter());
    Hive.registerAdapter(LengthAdapter());
    Hive.registerAdapter(MeasuresAdapter());
    Hive.registerAdapter(MetricAdapter());
    Hive.registerAdapter(StepAdapter());

    await Hive.deleteBoxFromDisk(recipesBoxName);
    await Hive.deleteBoxFromDisk(favouriteRecipes);
    await Hive.deleteBoxFromDisk(mealPlans);

    if (!Hive.isBoxOpen(recipesBoxName)) {
      await Hive.openBox<Recipe>(recipesBoxName);
    }
    if (!Hive.isBoxOpen(favouriteRecipes)) {
      await Hive.openBox<dynamic>(favouriteRecipes);
    }
    if (!Hive.isBoxOpen(mealPlans)) {
      await Hive.openBox<MealPlan>(mealPlans);
    }
  }
}
