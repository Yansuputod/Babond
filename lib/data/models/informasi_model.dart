import 'package:babond/domain/entities/informasi.dart';

class InformasiModel extends Informasi {
  InformasiModel({
    required super.id,
    required super.title,
    required super.image,
    required super.content,
    required super.link,
    required super.source,
    required super.contentSelector,
  });

  factory InformasiModel.fromMap(Map<String, dynamic> map) {
    return InformasiModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      content: map['content'] ?? '',
      link: map['link'] ?? '',
      source: map['source'] ?? '',
      contentSelector: map['contentSelector'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'content': content,
      'link': link,
      'source': source,
      'contentSelector': contentSelector,
    };
  }

  static List<InformasiModel> dummyList = [
    InformasiModel(
      id: '1',
      title: 'Jenis - Jenis Bibit Babi',
      image: 'assets/informasi/info1.jpeg',
      content: '',
      link: 'https://sulahan.desa.id/artikel/2022/5/5/jangan-salah-plih-babi-inilah-jenis-babi-yang-baik-dan-cocok-untuk-penggemukan-dan-pembibitan',
      source: 'Sulahan',
      contentSelector: '.main-content',
    ),
    InformasiModel(
      id: '2',
      title: 'Jenis - Jenis Pakan Babi',
      image: 'assets/informasi/info2.jpg',
      content: '',
      link: 'https://gdm.id/pakan-babi-penggemukan/',
      source: 'GDM',
      contentSelector: '.post-single-page',
    ),
    InformasiModel(
      id: '3',
      title: 'Teknik Beternak Modern',
      image: 'assets/img/dummy2.jpeg',
      content: '',
      link: 'https://www.liputan6.com/tag/peternakan',
      source: 'Liputan6',
      contentSelector: '.article-content',
    ),
  ];
}
