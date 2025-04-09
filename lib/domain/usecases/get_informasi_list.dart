import 'package:babond/domain/entities/informasi.dart';
import 'package:babond/domain/repositories/informasi_repository.dart';

class GetInformasiList {
  final InformasiRepository repository;

  GetInformasiList(this.repository);

  Future<List<Informasi>> execute() {
    return repository.getInformasiList();
  }
}
