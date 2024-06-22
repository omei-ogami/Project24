import 'package:flutter/material.dart';
import 'package:project_24/view_models/activity_vm.dart';
import 'services/navigation.dart';
import 'package:project_24/models/activity.dart';
import 'data/testing_data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 138, 246, 170),
  ),
  textTheme: GoogleFonts.inconsolataTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Firebase initialized successfully");

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NavigationService>(create: (_) => NavigationService()),
        ChangeNotifierProvider<ActivityViewModel>(create: (_) => ActivityViewModel()),
      ],
      child: MaterialApp.router(
        theme: theme,
        routerConfig: routerConfig,
        // Allow the Navigator built by the MaterialApp to restore the navigation stack when app restarts
        restorationScopeId: 'app',
      ),
    );
  }
}
