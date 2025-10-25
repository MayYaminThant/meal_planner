import 'package:hive/hive.dart';

part 'meal_plan.g.dart';

@HiveType(typeId: 9)
class MealPlan extends HiveObject {
  @HiveField(1)
  final String day;

  @HiveField(2)
  final List<int> recipeIds;

  MealPlan({
    required this.day,
    required this.recipeIds,
  });
}
