import 'dart:convert';
import 'package:http/http.dart' as http;

class LivroApi {
  String volumeInfo;
  String id;
  String autor;
  String titulo;
  String descricao;
  String numPag;

  LivroApi({
    required this.volumeInfo,
    required this.id,
    required this.autor,
    required this.titulo,
    required this.descricao,
    required this.numPag,
  });

  static Future<List<LivroApi>> pesquisaLivros(String pesquisa) async {
    const chaveApi =
        'AIzaSyBtCAKKRTjNZi7VMdeEX3FtAImFaVumEzs'; // Substitua pela sua chave API válida
    final url =
        'https://www.googleapis.com/books/v1/volumes?q=$pesquisa&key=$chaveApi';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final items = responseData['items'];

      if (items != null) {
        List<LivroApi> listaLivros = [];

        for (var item in items) {
          var volumeInfo = item['volumeInfo'];
          var autor = volumeInfo['authors'] != null
              ? volumeInfo['authors'][0]
              : 'Autor Desconhecido';
          var titulo = volumeInfo['title'] ?? 'Título Desconhecido';
          var id = item['id'] ?? '';
          var numPag = volumeInfo['pageCount']?.toString() ?? '0';

          LivroApi livro = LivroApi(
            volumeInfo: volumeInfo.toString(),
            id: id.toString(),
            autor: autor.toString(),
            titulo: titulo.toString(),
            descricao: '',
            numPag: numPag.toString(),
          );

          listaLivros.add(livro);
        }

        return listaLivros;
      } else {
        print('Nenhum livro encontrado');
      }
    } else {
      print('Erro na requisição: ${response.statusCode}');
    }

    return []; // Caso não encontre nenhum livro ou ocorra um erro, retorna uma lista vazia
  }
}
