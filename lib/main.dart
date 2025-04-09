import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:babond/presentation/pages/onboarding_page.dart';
import 'package:babond/presentation/pages/main_navigation.dart';
import 'package:babond/presentation/bloc/informasi/informasi_bloc.dart';

import 'package:babond/domain/usecases/get_informasi_list.dart';
import 'package:babond/domain/usecases/get_informasi_detail.dart'; 

import 'package:babond/data/repositories/informasi_repository_impl.dart';
import 'package:babond/data/datasources/remote/scraper_service.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); // Pastikan splash tetap selama inisialisasi
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

    await Future.delayed(const Duration(seconds: 2));  // Durasi splash screen
    FlutterNativeSplash.remove();  // Menghapus splash screen setelah selesai
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
    if (_isLoading) return const SizedBox.shrink(); // Menunggu splash selesai

    final remoteDataSource = InformasiRemoteDataSourceImpl();
    final repository = InformasiRepositoryImpl(remoteDataSource);
    final getInformasiList = GetInformasiList(repository);
    final getInformasiDetail = GetInformasiDetail(repository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => InformasiBloc(
            getList: getInformasiList,
            getDetail: getInformasiDetail,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _isFirstTime
            ? OnBoardingPage(onFinish: _completeOnboarding)
            : const MainNavigation(),
      ),
    );
  }
}
