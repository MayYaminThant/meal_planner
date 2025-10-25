import 'package:hive/hive.dart';

import '../components/export_files.dart';

class HiveMealPlanService {
  final Box<MealPlan> _mealPlanBox;
  final Box<Recipe> _recipeBox;

  HiveMealPlanService(this._mealPlanBox, this._recipeBox);

  List<MealPlan> getAllMealPlans() {
    return _mealPlanBox.values.toList();
  }

  MealPlan? getMealPlanForDay(String day) {
    return _mealPlanBox.get(day);
  }

  Future<void> saveMealPlan(String day, List<int> recipeIds) async {
    final plan = MealPlan(day: day, recipeIds: recipeIds);
    await _mealPlanBox.put(day, plan);
  }

  Future<void> removeMealPlan(String day) async {
    await _mealPlanBox.delete(day);
  }

  List<Recipe> getRecipesFromIds(List<int> ids) {
    return _recipeBox.values
        .where((recipe) => ids.contains(recipe.id))
        .toList();
  }
}
