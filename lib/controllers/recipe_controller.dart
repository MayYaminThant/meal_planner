import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meal_planner/components/export_files.dart';
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

  void toggleFavourite(Recipe recipe) async {
    final favBox = HiveBoxes.getFavouriteBox();

    if (isFavourite(recipe.id ?? -1)) {
      final toRemove = favBox.values.firstWhere((r) => r.id == recipe.id);
      await toRemove.delete();
    } else {
      await favBox.add(recipe);
    }

    _favRecipeList = favBox.values.toList();
    notifyListeners();
  }

  bool isFavourite(int id) {
    return _favRecipeList.any((r) => r.id == id);
  }

  Future<bool> checkOfflineConnectivity() async {
    final connectivity = await Connectivity().checkConnectivity();
    return connectivity.contains(ConnectivityResult.none);
  }

  Future<void> getRandomRecipeList() async {
    final allBox = HiveBoxes.getAllRecipeBox();
    final favBox = HiveBoxes.getFavouriteBox();

    _recipeList = allBox.values.toList();
    _favRecipeList = favBox.values.toList();

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
    final allBox = HiveBoxes.getAllRecipeBox();
    final favBox = HiveBoxes.getFavouriteBox();

    _recipeList = allBox.values.toList();
    _favRecipeList = favBox.values.toList();

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
