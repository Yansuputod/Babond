import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:babond/domain/entities/informasi.dart';
import 'package:babond/presentation/bloc/informasi/informasi_bloc.dart';
import 'package:babond/presentation/bloc/informasi/informasi_event.dart';
import 'package:babond/presentation/bloc/informasi/informasi_state.dart';
import 'package:babond/core/constants/app_colors.dart';

class InformasiDetailPage extends StatelessWidget {
  final Informasi info;

  const InformasiDetailPage({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(info.title),
        centerTitle: true,
        backgroundColor: AppColors.pinkDark,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<InformasiBloc, InformasiState>(
        builder: (context, state) {
          if (state is InformasiDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is InformasiDetailLoaded && state.link == info.link) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<InformasiBloc>().add(
                  GetInformasiDetailEvent(
                    link: info.link,
                    selector: info.contentSelector,
                  ),
                );
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Gambar
                    Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.pinkMedium, width: 3),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),
                        child: info.image.startsWith('http')
                            ? Image.network(
                                info.image,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                info.image,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),

                    // Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        info.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.pinkDark,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(color: AppColors.pinkMedium),
                    ),
                    const SizedBox(height: 5),

                    // Konten HTML
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Html(
                        data: state.htmlContent,
                        style: {
                          "*": Style(
                            fontSize: FontSize(18),
                            color: Colors.black,
                            fontFamily: 'Roboto',
                            textAlign: TextAlign.justify,
                          ),
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is InformasiError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            context.read<InformasiBloc>().add(
              GetInformasiDetailEvent(
                link: info.link,
                selector: info.contentSelector,
              ),
            );
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
