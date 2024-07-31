import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:autofarm/views/login/login_view.dart';
import 'package:autofarm/views/home/home_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();  // Initialize GetStorage
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: _getInitialScreen(),
    );
  }

  // Function to decide which screen to show based on stored value
  Widget _getInitialScreen() {
    final storage = GetStorage();
    bool isLoggedIn = storage.read('is_logged_in') ?? false;  // Read stored value, default to false

    if (isLoggedIn) {
      return HomeView();  // Replace with your actual HomeScreen widget
    } else {
      return LoginPage();  // Your existing LoginPage
    }
  }
}
