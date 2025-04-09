abstract class InformasiState {}

class InformasiInitial extends InformasiState {}

class InformasiLoading extends InformasiState {}

class InformasiLoaded extends InformasiState {
  final List<dynamic> list; // ganti dengan List<Informasi> kalau udah pasti
  InformasiLoaded(this.list);
}

class InformasiError extends InformasiState {
  final String message;
  InformasiError(this.message);
}

class InformasiDetailLoading extends InformasiState {}

class InformasiDetailLoaded extends InformasiState {
  final String htmlContent;
  final String link;

  InformasiDetailLoaded({
    required this.htmlContent,
    required this.link,
  });
}

class InformasiDetailError extends InformasiState {
  final String message;
  InformasiDetailError(this.message);
}
