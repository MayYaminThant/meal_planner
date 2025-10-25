import 'package:intl/intl.dart';

import '../../components/export_files.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({super.key});
  static const String routeName = "/meal_plan";

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  late HiveMealPlanService _mealPlanService;
  final List<String> _days = [];

  @override
  void initState() {
    super.initState();
    for (int i = 1; i <= 7; i++) {
      _days.add(DateFormat('EEEE').format(DateTime(2024, 1, i)));
    }
    final mealPlanBox = HiveBoxes.getMealPlanBox();
    final recipeBox = HiveBoxes.getAllRecipeBox();
    _mealPlanService = HiveMealPlanService(mealPlanBox, recipeBox);
  }

  @override
  Widget build(BuildContext context) {
    _mealPlanService.getAllMealPlans();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Meal Plan'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: _days.length,
        itemBuilder: (context, index) {
          final day = _days[index];
          final plan = _mealPlanService.getMealPlanForDay(day);
          final recipes = plan == null
              ? []
              : _mealPlanService.getRecipesFromIds(plan.recipeIds);

          return Card(
            margin: const EdgeInsets.all(12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              title: Text(
                day,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: [
                if (recipes.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton.icon(
                      onPressed: () {
                        _showRecipeSelectionDialog(day);
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("Add recipe"),
                    ),
                  )
                else
                  Column(
                    children: [
                      ...recipes.map(
                        (recipe) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(recipe.image),
                          ),
                          title: Text(recipe.title),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              final newIds = List<int>.from(plan!.recipeIds)
                                ..remove(recipe.id);
                              _mealPlanService.saveMealPlan(day, newIds);
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          _showRecipeSelectionDialog(day);
                        },
                        icon: const Icon(Icons.add),
                        label: const Text("Add more"),
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showRecipeSelectionDialog(String day) async {
    final recipeBox = HiveBoxes.getAllRecipeBox();
    final recipes = recipeBox.values.toList();

    final selected = await showDialog<List<int>>(
      context: context,
      builder: (context) {
        final selectedIds = <int>{};
        return AlertDialog(
          title: Text('Select Recipes for $day'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return CheckboxListTile(
                  value: selectedIds.contains(recipe.id),
                  title: Text(recipe.title ?? ''),
                  onChanged: (val) {
                    if (val == true) {
                      selectedIds.add(recipe.id ?? -1);
                    } else {
                      selectedIds.remove(recipe.id);
                    }
                    (context as Element).markNeedsBuild();
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedIds.toList());
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );

    if (selected != null) {
      await _mealPlanService.saveMealPlan(day, selected);
      setState(() {});
    }
  }
}
