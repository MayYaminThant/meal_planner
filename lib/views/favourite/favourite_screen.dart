import '../../components/export_files.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});
  static const String routeName = "/favorite_screen";

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: _bodyWidget(),
    ));
  }

  Widget _bodyWidget() {
    return Container(
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
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const Text(
                  'Favourite',
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
    );
  }

  Widget _mainBodyWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 20),
          Expanded(child: recipeListWidget()),
        ],
      ),
    );
  }

  Widget recipeListWidget() {
    return Consumer<RecipeController>(builder: (_, controller, __) {
      return GridView.builder(
        itemCount: controller.favRecipeList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          mainAxisSpacing: 4,
          crossAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final recipe = controller.favRecipeList[index];
          return RecipeCard(
            recipe: recipe,
            isFavorite: controller.favRecipeList.indexWhere((e) {
                  return e.id == recipe.id;
                }) !=
                -1,
            // onTap: () => Navigator.pushNamed(
            //   context,
            //   '/recipe_details',
            //   arguments: recipe,
            // ),
            onFavoriteToggle: () async {
              await controller.toggleFavourite(recipe);
            },
          );
        },
      );
    });
  }
}
