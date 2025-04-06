import 'package:babond/presentation/pages/main_navigation.dart';
import 'package:babond/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool _isLoading = true;
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirst = prefs.getBool('is_first_time') ?? true;

    setState(() {
      _isFirstTime = isFirst;
      _isLoading = false;
    });

    // delay untuk splash
    await Future.delayed(const Duration(seconds: 2));
    FlutterNativeSplash.remove();
  }

  void _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_first_time', false);
    setState(() {
      _isFirstTime = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const SizedBox.shrink(); // kosong saat loading

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isFirstTime
          ? OnBoardingPage(onFinish: _completeOnboarding)
          : const MainNavigation(),
    );
  }
}
