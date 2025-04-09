import 'package:babond/domain/repositories/informasi_repository.dart';

class GetInformasiDetail {
  final InformasiRepository repository;

  GetInformasiDetail(this.repository);

  Future<String> execute(String link, String selector) {
    return repository.getInformasiDetail(link, selector);
  }
}
