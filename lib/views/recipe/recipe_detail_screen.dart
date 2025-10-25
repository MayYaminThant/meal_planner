import 'dart:convert';

import 'package:flutter_html/flutter_html.dart';
import 'package:hive/hive.dart';

import '../../components/export_files.dart';

class RecipeDetailScreen extends StatefulWidget {
  const RecipeDetailScreen({super.key, required this.recipe});
  final Recipe recipe;
  static const String routeName = "/recipe_detail_screen";

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  bool? isFavorite;
  Box<Recipe>? favoritesBox;
  Map<String, dynamic>? nutritionData;

  @override
  void initState() {
    super.initState();
    favoritesBox = HiveBoxes.getFavouriteBox();
    isFavorite = favoritesBox?.containsKey(widget.recipe.id) ?? false;
    context
        .read<RecipeController>()
        .getSimilarRecipeList(similarId: widget.recipe.id ?? -1);
    _parseRecipeData();
  }

  void _parseRecipeData() {
    try {
      final decoded = jsonDecode(jsonEncode(widget.recipe));
      nutritionData = decoded['nutrition'];
    } catch (e) {
      nutritionData = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 300,
              // pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                title: Text(
                  widget.recipe.title ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                background: Hero(
                  tag: widget.recipe.id ?? '11',
                  child: Image.network(
                    widget.recipe.image ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 100),
                    ),
                  ),
                ),
              ),
              leading: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: Colors.white,
                style: const ButtonStyle(iconSize: WidgetStatePropertyAll(26)),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    (isFavorite ?? false)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    context
                        .read<RecipeController>()
                        .toggleFavourite(widget.recipe);
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Prep time
                    Row(
                      children: [
                        const Icon(Icons.schedule, color: Colors.teal),
                        const SizedBox(width: 6),
                        Text("${widget.recipe.readyInMinutes} minutes",
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ..._ingredientsWidget(),
                    const SizedBox(height: 36),
                    ..._instructionsWidget(),
                    const SizedBox(height: 36),
                    ..._similarRecipesWidget(),

                    //  Nutrition
                    // if (widget.recipe. != null) ...[
                    //   const Text(
                    //     "Nutritional Information",
                    //     style: TextStyle(
                    //       fontSize: 22,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    //   const SizedBox(height: 8),
                    //   _buildNutritionTable(),
                    // ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _ingredientsWidget() {
    return [
      Text(
        "Ingredients".toUpperCase(),
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      widget.recipe.extendedIngredients == null ||
              widget.recipe.extendedIngredients!.isEmpty
          ? const Text("No ingredients found.")
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: ColorUtils.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.recipe.extendedIngredients!.length,
                itemBuilder: (context, index) {
                  final item = widget.recipe.extendedIngredients![index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Text(
                          item.original ?? "Unknown ingredient",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      if (index !=
                          (widget.recipe.extendedIngredients?.length ?? 0) - 1)
                        const Divider(
                          height: 1.4,
                          thickness: 0.2,
                        ),
                    ],
                  );
                },
              ),
            ),
    ];
  }

  List<Widget> _instructionsWidget() {
    return [
      Text(
        "Instructions".toUpperCase(),
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8),
      Container(
        // padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorUtils.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Html(
          data: widget.recipe.instructions ?? "No instructions available.",
        ),
      ),
    ];
  }

  List<Widget> _similarRecipesWidget() {
    return context.read<RecipeController>().similarrecipeList.map((recipe) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.all(8),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipe Image
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  recipe.image ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported, size: 40),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title ?? 'Untitled Recipe',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 6),
                    if (recipe.summary != null)
                      Text(
                        recipe.summary!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  // Widget _buildNutritionTable() {
  //   final nutrients = nutritionData!['nutrients'] as List<dynamic>? ?? [];
  //   return Card(
  //     elevation: 3,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     child: Padding(
  //       padding: const EdgeInsets.all(12),
  //       child: Column(
  //         children: nutrients.take(6).map((n) {
  //           return Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(n['name'] ?? '',
  //                   style: const TextStyle(fontWeight: FontWeight.w500)),
  //               Text("${n['amount']}${n['unit'] ?? ''}",
  //                   style: const TextStyle(color: Colors.grey)),
  //             ],
  //           );
  //         }).toList(),
  //       ),
  //     ),
  //   );
  // }
}
