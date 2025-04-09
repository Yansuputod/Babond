import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:babond/core/constants/app_colors.dart';
import 'package:babond/presentation/bloc/informasi/informasi_bloc.dart';
import 'package:babond/presentation/bloc/informasi/informasi_state.dart';
import 'package:babond/presentation/bloc/informasi/informasi_event.dart';
import 'package:babond/presentation/pages/informasi_detail_page.dart';

class InformasiPage extends StatefulWidget {
  const InformasiPage({super.key});

  @override
  State<InformasiPage> createState() => _InformasiPageState();
}

class _InformasiPageState extends State<InformasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      body: BlocBuilder<InformasiBloc, InformasiState>(
        builder: (context, state) {
          if (state is InformasiLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InformasiLoaded) {
            if (state.list.isEmpty) {
              return const Center(child: Text('Belum ada informasi tersedia.'));
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<InformasiBloc>().add(GetInformasiListEvent());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  final info = state.list[index];
                  final isNetworkImage = info.image.startsWith('http');

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => InformasiDetailPage(info: info),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        border: Border.all(color: AppColors.pinkMedium, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
                            child: isNetworkImage
                                ? Image.network(
                                    info.image,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const SizedBox(
                                      height: 180,
                                      child: Center(child: Icon(Icons.broken_image)),
                                    ),
                                  )
                                : Image.asset(
                                    info.image,
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => const SizedBox(
                                      height: 180,
                                      child: Center(child: Icon(Icons.broken_image)),
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              info.title,
                              style: const TextStyle(
                                color: AppColors.pinkDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is InformasiError) {
            return Center(child: Text('Gagal memuat data: ${state.message}'));
          }

          return const Center(child: Text('Tidak ada data'));
        },
      ),
    );
  }
}
