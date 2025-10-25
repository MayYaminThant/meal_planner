import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_planner/components/export_files.dart';
import 'package:meal_planner/hive/favourite_recipe_hive_service.dart';
import 'package:meal_planner/services/api.dart';

class RecipeController extends ChangeNotifier {
  String? _searchKey;
  String? get searchKey => _searchKey;
  set searchKey(String? searchKey) {
    if (_searchKey == searchKey) return;
    _searchKey = searchKey;
    if (_searchKey?.isNotEmpty ?? false) {
      getRecipeListByIngredients();
    } else {
      getRandomRecipeList();
    }
    notifyListeners();
  }

  List<Recipe> _recipeList = [];
  List<Recipe> get recipeList => _recipeList;
  set recipeList(List<Recipe> recipeList) {
    _recipeList = recipeList;
    notifyListeners();
  }

  List<Recipe> _favRecipeList = [];
  List<Recipe> get favRecipeList => _favRecipeList;
  set favRecipeList(List<Recipe> favRecipeList) {
    _favRecipeList = favRecipeList;
    notifyListeners();
  }

  List<Recipe> _similarrecipeList = [];
  List<Recipe> get similarrecipeList => _similarrecipeList;
  set similarrecipeList(List<Recipe> similarrecipeList) {
    _similarrecipeList = similarrecipeList;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool isLoading) {
    if (_isLoading == isLoading) return;
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<void> toggleFavourite(Recipe recipe) async {
    try {
      final Box<Recipe> recipeBox = HiveBoxes.getAllRecipeBox();
      final Box<dynamic> favBox = HiveBoxes.getFavouriteIdBox();
      final HiveFavouriteRecipeService hiveFavouriteRecipeService =
          HiveFavouriteRecipeService(favBox, recipeBox);

      await hiveFavouriteRecipeService.toggleFavourite(recipe.id ?? -1);

      _favRecipeList = hiveFavouriteRecipeService
          .getRecipesFromIds(hiveFavouriteRecipeService.getFavouriteIds());
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool isFavourite(int id) {
    return _favRecipeList.any((r) => r.id == id);
  }

  Future<bool> checkOfflineConnectivity() async {
    final connectivity = await Connectivity().checkConnectivity();
    return connectivity.contains(ConnectivityResult.none);
  }

  Future<void> getRandomRecipeList() async {
    final Box<dynamic> favBox = HiveBoxes.getFavouriteIdBox();
    final Box<Recipe> allBox = HiveBoxes.getAllRecipeBox();
    try {
      final HiveFavouriteRecipeService hiveFavouriteRecipeService =
          HiveFavouriteRecipeService(favBox, allBox);

      _recipeList = allBox.values.toList();
      _favRecipeList = hiveFavouriteRecipeService
          .getRecipesFromIds(hiveFavouriteRecipeService.getFavouriteIds());
    } catch (e) {
      debugPrint(e.toString());
    }
    if (await checkOfflineConnectivity()) {
      return;
    }
    recipeList.clear();
    isLoading = true;

    Api.getRandomRecipes().then((response) async {
      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        if (response.data['recipes'] is List) {
          final List<dynamic> results = response.data['recipes'];
          for (var data in results) {
            _recipeList.add(Recipe.fromJson(data));
          }

          await allBox.clear();
          await allBox.addAll(_recipeList);
          _isLoading = false;
          notifyListeners();
        }
      }
    });
  }

  Future<void> getRecipeListByIngredients() async {
    final Box<Recipe> allBox = HiveBoxes.getAllRecipeBox();
    final Box<dynamic> favBox = HiveBoxes.getFavouriteIdBox();
    try {
      final HiveFavouriteRecipeService hiveFavouriteRecipeService =
          HiveFavouriteRecipeService(favBox, allBox);

      _recipeList = allBox.values.toList();
      _favRecipeList = hiveFavouriteRecipeService
          .getRecipesFromIds(hiveFavouriteRecipeService.getFavouriteIds());
    } catch (e) {
      debugPrint(e.toString());
    }

    if (await checkOfflineConnectivity()) {
      return;
    }
    recipeList.clear();
    isLoading = true;

    Api.getRecipesByIngredients(searchIngredients: searchKey ?? '')
        .then((response) async {
      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        if (response.data is List) {
          for (var data in response.data) {
            _recipeList.add(Recipe.fromJson(data));
          }

          await allBox.clear();
          await allBox.addAll(_recipeList);
          _isLoading = false;
          notifyListeners();
        }
      }
    });
  }

  Future<void> getSimilarRecipeList({required int similarId}) async {
    if (await checkOfflineConnectivity()) {
      return;
    }
    similarrecipeList.clear();

    Api.getSimilarRecipes(similarId: similarId).then((response) {
      if (response != null &&
          (response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        if (response.data is List) {
          for (var data in response.data) {
            similarrecipeList.add(Recipe.fromJson(data));
          }
          notifyListeners();
        }
      }
    });
  }
}
