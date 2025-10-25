import 'package:hive/hive.dart';

import '../components/export_files.dart';

class HiveFavouriteRecipeService {
  static const String _key = 'favourite_ids';
  final Box<Recipe> recipeBox;
  final Box _favBox;

  HiveFavouriteRecipeService(this._favBox, this.recipeBox);

  /// Get all favourite recipe IDs
  List<int> getFavouriteIds() {
    return List<int>.from(_favBox.get(_key, defaultValue: []));
  }

  /// Check if a recipe is favourite
  bool isFavourite(int id) {
    final favIds = getFavouriteIds();
    return favIds.contains(id);
  }

  /// Add recipe to favourites
  Future<void> addFavourite(int id) async {
    final favIds = getFavouriteIds();
    if (!favIds.contains(id)) {
      favIds.add(id);
      await _favBox.put(_key, favIds);
    }
  }

  /// Remove recipe from favourites
  Future<void> removeFavourite(int id) async {
    final favIds = getFavouriteIds();
    favIds.remove(id);
    await _favBox.put(_key, favIds);
  }

  /// Toggle favourite state
  Future<void> toggleFavourite(int id) async {
    if (isFavourite(id)) {
      await removeFavourite(id);
    } else {
      await addFavourite(id);
    }
  }

  /// Clear all favourites
  Future<void> clearAll() async {
    await _favBox.put(_key, []);
  }

  List<Recipe> getRecipesFromIds(List<int> ids) {
    return recipeBox.values.where((recipe) => ids.contains(recipe.id)).toList();
  }
}
