import 'dart:developer';

import '../components/export_files.dart';
import '../views/widget/error_text.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    log(settings.name.toString());
    switch (settings.name) {
      case FavoriteScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const FavoriteScreen(),
        );
      case RecipeDetailScreen.routeName:
        final RecipeDetailScreen args =
            settings.arguments as RecipeDetailScreen;
        return MaterialPageRoute(
          builder: (_) => RecipeDetailScreen(recipe: args.recipe),
        );
      case MealPlanScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const MealPlanScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Center(
                child: ErrorText(
                  text: "Route name not found ${settings.name}",
                ),
              ),
            ),
          ),
        );
    }
  }
}
