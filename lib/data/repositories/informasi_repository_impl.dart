import 'package:babond/data/datasources/remote/scraper_service.dart';
import 'package:babond/data/models/informasi_model.dart';
import 'package:babond/domain/entities/informasi.dart';
import 'package:babond/domain/repositories/informasi_repository.dart';

class InformasiRepositoryImpl implements InformasiRepository {
  final InformasiRemoteDataSource remoteDataSource;

  InformasiRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Informasi>> getInformasiList() async {
    final dummy = InformasiModel.dummyList;
    final result = await remoteDataSource.fetchInformasiList(dummy);
    return result;
  }

  @override
  Future<String> getInformasiDetail(String link, String contentSelector) async {
    return await remoteDataSource.fetchInformasiContent(link, contentSelector);
  }
}
