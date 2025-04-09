import 'dart:developer';
import 'package:babond/data/models/informasi_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

abstract class InformasiRemoteDataSource {
  Future<List<InformasiModel>> fetchInformasiList(List<InformasiModel> list);
  Future<String> fetchInformasiContent(String link, String selector);
}

class InformasiRemoteDataSourceImpl implements InformasiRemoteDataSource {
  @override
  Future<List<InformasiModel>> fetchInformasiList(List<InformasiModel> list) async {
    return list; // tidak scraping di list, hanya pakai dummyList
  }

  @override
  Future<String> fetchInformasiContent(String link, String selector) async {
    try {
      final response = await http.get(Uri.parse(link));
      if (response.statusCode == 200) {
        final document = parse(response.body);
        final contentElement = document.querySelector(selector);

        if (contentElement == null) {
          log('Selector tidak ditemukan di halaman: $link', name: 'ScraperContent');
          return '-';
        }

        final allowedTags = [
          'p', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6',
          'i', 'b', 'em', 'u', 'strong',
          'ul', 'ol', 'li', 'blockquote',
          'pre', 'code', 'span', 'div'
        ];

        final buffer = StringBuffer();

        for (final node in contentElement.children) {
          if (allowedTags.contains(node.localName)) {
            buffer.writeln(node.outerHtml);
          }
        }

        final result = buffer.toString().trim();
        return result.isEmpty ? '-' : result;
      } else {
        log('Gagal memuat halaman ($link) status: ${response.statusCode}', name: 'ScraperContent');
      }
    } catch (e) {
      log('Error scraping $link: $e', name: 'ScraperContent');
    }

    return '-';
  }
}
