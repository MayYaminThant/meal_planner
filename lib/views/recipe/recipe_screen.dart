import 'package:connectivity_plus/connectivity_plus.dart';

import '/components/export_files.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});
  static const String routeName = "/recipe_screen";

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final TextEditingController _searchRecipeTextController =
      TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
      _snackbarController;
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchRecipeTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      WifiController wifiController = context.read<WifiController>();
      await checkConnectivity(wifiController);
    });
    context.read<RecipeController>().getRandomRecipeList();
    // I don't know the main route so I used random recipe list
    // I wanna use pageview but random recipe list does't include limit offset/page number
    super.initState();
  }

  Future<void> checkConnectivity(WifiController wifiController) async {
    final connectivity = await Connectivity().checkConnectivity();
    wifiController.isOffline = connectivity.contains(ConnectivityResult.none);

    Connectivity().onConnectivityChanged.listen((result) {
      wifiController.isOffline = result.contains(ConnectivityResult.none);
    });
  }

  void showSnackBar(bool isOffline) {
    if (isOffline) {
      _snackbarController ??= ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('You are offline'),
          backgroundColor: ColorUtils.accentColor.withOpacity(0.2),
          duration: const Duration(days: 1),
        ),
      );
    } else {
      _snackbarController?.close();
      _snackbarController = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: _bodyWidget(),
      ),
      drawer: _drawerWidget(),
    );
  }

  Widget _bodyWidget() {
    return InkWell(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Container(
        color: ColorUtils.primaryColor,
        width: SizeMedia.screenWidth(context),
        height: SizeMedia.screenHeight(context),
        child: Stack(
          children: [
            BackgroundLayerWidget(child: _mainBodyWidget()),
            Positioned(
              top: 5,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState?.openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const Text(
                    'Recipes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mainBodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          _searchRecipeWidget(),
          const SizedBox(height: 20),
          Expanded(child: recipeListWidget()),
        ],
      ),
    );
  }

  Widget _searchRecipeWidget() {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide:
          BorderSide(width: 0.6, color: ColorUtils.greyColor.withOpacity(0.7)),
      borderRadius: BorderRadius.circular(12),
    );
    return TextFormField(
      focusNode: _focusNode,
      controller: _searchRecipeTextController,
      decoration: InputDecoration(
        isDense: true,
        hintText: 'Enter ingredients',
        hintStyle: TextStyle(
          color: ColorUtils.greyColor,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder.copyWith(
          borderSide: BorderSide(width: 1, color: ColorUtils.primaryColor),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchRecipeTextController.clear();
            context.read<RecipeController>().searchKey = null;
            _focusNode.unfocus();
          },
        ),
      ),
      onFieldSubmitted: (value) {
        context.read<RecipeController>().searchKey = value;
        _focusNode.unfocus();
      },
      textInputAction: TextInputAction.next,
      style: const TextStyle(fontSize: 14.5),
      onTap: () {},
    );
  }

  Widget recipeListWidget() {
    return Consumer<RecipeController>(builder: (_, controller, __) {
      return GridView.builder(
        itemCount: controller.recipeList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          mainAxisSpacing: 4,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final recipe = controller.recipeList[index];
          return RecipeCard(
            recipe: recipe,
            isFavorite: false, // favorites.contains(recipe.id),
            // onTap: () => Navigator.pushNamed(
            //   context,
            //   '/recipe_details',
            //   arguments: recipe,
            // ),
            // onFavoriteToggle: () => toggleFavorite(recipe),
          );
        },
      );
    });
  }

  Drawer _drawerWidget() {
    return Drawer(
      backgroundColor: ColorUtils.primaryColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BackButton(
              onPressed: () {
                _scaffoldKey.currentState?.closeDrawer();
              },
              color: Colors.white,
              style: const ButtonStyle(
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 18, vertical: 4))),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
              child: Text(
                'Recipe App',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 26),
              ),
            ),
            const SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, FavoriteScreen.routeName);
              },
              child: const Row(
                children: [
                  SizedBox(width: 20),
                  Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'Favourite',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                SizedBox(width: 20),
                Icon(
                  Icons.calendar_today_rounded,
                  color: Colors.white,
                ),
                SizedBox(width: 20),
                Text(
                  'Meal Planner',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
