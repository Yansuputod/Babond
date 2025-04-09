import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:babond/core/constants/app_colors.dart';
import 'home_page.dart';
import 'kandang_page.dart';
import 'informasi_page.dart';

import 'package:babond/presentation/bloc/informasi/informasi_bloc.dart';
import 'package:babond/domain/usecases/get_informasi_list.dart';
import 'package:babond/domain/usecases/get_informasi_detail.dart';
import 'package:babond/data/repositories/informasi_repository_impl.dart';
import 'package:babond/data/datasources/remote/scraper_service.dart';
import 'package:babond/presentation/bloc/informasi/informasi_event.dart';


class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigation();
}

class _MainNavigation extends State<MainNavigation> {
  int _currentIndex = 0;

  late final InformasiBloc _informasiBloc;

  @override
  void initState() {
    super.initState();
    final remote = InformasiRemoteDataSourceImpl();
    final repo = InformasiRepositoryImpl(remote);
    _informasiBloc = InformasiBloc(
      getList: GetInformasiList(repo),
      getDetail: GetInformasiDetail(repo),
    );
    _informasiBloc.add(GetInformasiListEvent()); // Load the list once when the app starts
  }

  final List<Widget> _pages = [
    const HomePage(),
    const KandangPage(),
    const InformasiPage(),
  ];

  @override
  void dispose() {
    _informasiBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _informasiBloc,
      child: Scaffold(
        backgroundColor: Colors.white, // Latar belakang putih
        appBar: AppBar(
          backgroundColor: AppColors.pinkDark, // AppBar jadi pink
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white), // Ikon putih
            onPressed: () {},
          ),
          centerTitle: true,
          title: const Text(
            'Babond',
            style: TextStyle(
              color: Colors.white, // Teks putih
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_rounded, color: Colors.white), // Ikon putih
              onPressed: () {},
            ),
          ],
        ),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: AppColors.pinkDark, // Navbar jadi pink
          selectedItemColor: Colors.white, // Ikon yang dipilih jadi putih
          unselectedItemColor: Colors.white.withOpacity(0.7), // Ikon yang tidak dipilih jadi putih dengan transparansi
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.pets_rounded), label: 'Kandang'),
            BottomNavigationBarItem(icon: Icon(Icons.info_rounded), label: 'Informasi'),
          ],
        ),
      ),
    );
  }
}
