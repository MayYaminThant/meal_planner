import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_planner/services/hive_service.dart';
import 'package:provider/single_child_widget.dart';

import 'components/export_files.dart';
import 'components/routers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(
    fileName: "assets/.env",
  );
  await HiveService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  List<SingleChildWidget> get multiProviders {
    return [
      ChangeNotifierProvider(create: (_) => RecipeController()),
      ChangeNotifierProvider(create: (_) => WifiController()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: multiProviders,
      child: MaterialApp(
        title: 'Meal Planner',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        home: const RecipeScreen(),
        onGenerateRoute: Routers.generateRoute,
      ),
    );
  }
}
