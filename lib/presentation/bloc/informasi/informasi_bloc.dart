import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:babond/domain/usecases/get_informasi_list.dart';
import 'package:babond/domain/usecases/get_informasi_detail.dart';
import 'package:babond/presentation/bloc/informasi/informasi_event.dart';
import 'package:babond/presentation/bloc/informasi/informasi_state.dart';

class InformasiBloc extends Bloc<InformasiEvent, InformasiState> {
  final GetInformasiList getList;
  final GetInformasiDetail getDetail;

  InformasiBloc({
    required this.getList,
    required this.getDetail,
  }) : super(InformasiInitial()) {
    on<GetInformasiListEvent>((event, emit) async {
      if (state is InformasiLoaded) return;

      emit(InformasiLoading());
      try {
        final result = await getList.execute();
        emit(InformasiLoaded(result));
      } catch (e) {
        emit(InformasiError('Gagal memuat informasi'));
      }
    });

    on<GetInformasiDetailEvent>((event, emit) async {
      emit(InformasiDetailLoading());
      try {
        final htmlContent = await getDetail.execute(event.link, event.selector);
        emit(InformasiDetailLoaded(htmlContent: htmlContent, link: event.link));
      } catch (e) {
        emit(InformasiDetailError('Gagal memuat detail informasi'));
      }
    });
  }
}
