import 'package:equatable/equatable.dart';

abstract class InformasiEvent extends Equatable {
  const InformasiEvent();

  @override
  List<Object?> get props => [];
}

class GetInformasiListEvent extends InformasiEvent {}

class GetInformasiDetailEvent extends InformasiEvent {
  final String link;
  final String selector; 

  const GetInformasiDetailEvent({
    required this.link,
    required this.selector,
  });

  @override
  List<Object> get props => [link, selector];
}
