import 'package:babond/domain/entities/informasi.dart';

abstract class InformasiRepository {
  Future<List<Informasi>> getInformasiList();
  Future<String> getInformasiDetail(String link, String contentSelector);
}
