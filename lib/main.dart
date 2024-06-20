import 'package:flutter/material.dart';
import 'services/navigation.dart';
import 'package:project_24/models/activity.dart';
import 'data/testing_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 138, 246, 170),
  ),
  textTheme: GoogleFonts.inconsolataTextTheme(),
);

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider<NavigationService>(create: (_) => NavigationService()),
        Provider<List<Activity>>(create: (_) => testActivity),
      ],
      child: const App(),
    )
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: theme,
      routerConfig: routerConfig,
      // Allow the Navigator built by the MaterialApp to restore the navigation stack when app restarts
      restorationScopeId: 'app',
    );
  }
}
