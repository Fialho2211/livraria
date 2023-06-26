import 'package:flutter/material.dart';
import 'package:livraria/model/classes/livro.dart';
import 'package:livraria/biblioteca/widgets/livro_card.dart';
import '../../model/classes/livro_api.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _controller = TextEditingController();
  //Lista de Livros

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Future<void> _pesquisa() async {
    final pesquisa = _controller.text.trim();

    List<LivroApi> livros = await LivroApi.pesquisaLivros(pesquisa);

    for (var livro in livros) {
      print('Livro: ${livro.titulo}, Autor: ${livro.autor}, ID: ${livro.id}');

      print(
          '************************************************************************************');
    }

    _controller.clear();
  }

  // Future<void> pesquisaLivros(String pesquisa) async {
  //   const chaveApi = 'AIzaSyBtCAKKRTjNZi7VMdeEX3FtAImFaVumEzs';
  //   final url =
  //       'https://www.googleapis.com/books/v1/volumes?q=$pesquisa&key=$chaveApi';

  //   final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     final responseData = json.decode(response.body);
  //     final items = responseData['items'];

  //     if (items != null) {
  //       List<Map<String, String>> booksList = [];

  //       for (var item in items) {
  //         final volumeInfo = item['volumeInfo'];
  //         final String author = volumeInfo['authors'] != null
  //             ? volumeInfo['authors'][0]
  //             : 'Autor Desconhecido';
  //         final String title = volumeInfo['title'] ?? 'Título Desconhecido';
  //         final String id = item['id'] ?? '';
  //         final String numPag = volumeInfo['pageCount'].toString() ?? '0';

  //         Map<String, String> book = {
  //           'author': author,
  //           'title': title,
  //           'id': id,
  //           'pageCount': numPag,
  //         };

  //         booksList.add(book);
  //       }

  //       // Imprimir a lista de livros
  //       for (var book in booksList) {
  //         final author = book['author'];
  //         final title = book['title'];
  //         final id = book['id'];
  //         final pageCount = book['pageCount'];
  //         print(
  //           'Livro: $title, Autor: $author, Id: $id, Paginas: $pageCount',
  //         );
  //       }
  //     } else {
  //       print('Nenhum livro encontrado');
  //     }
  //   } else {
  //     print('Erro na requisição: ${response.statusCode}');
  //   }
  //   print(
  //       '************************************************************************************************');
  // }

  // void pesquisa() {
  //   final pesquisa = _controller.text.trim();

  //   if (pesquisa.isNotEmpty) {
  //     pesquisaLivros(pesquisa);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final List<Livro> livros = Livro.gerarLivros();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(212, 242, 246, 1),
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        automaticallyImplyLeading: false, //Remove o "voltar"
        title: SizedBox(
          width: 300,
          height: 40,
          child: TextField(
            decoration: const InputDecoration(
              //Backgroud do campo de pesquisa
              filled: true,
              fillColor: Color.fromRGBO(255, 255, 255, 1),

              //Texto dentro do campo
              hintText: 'Pesquisar por livros, autores ou editoras...',
              contentPadding: EdgeInsets.all(1.0),

              //Borda antes de clicar
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),

              //Borda depois de clicar
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),

              //Ícone antes do texto
              prefixIcon: Icon(
                Icons.search_outlined,
                color: Colors.black,
              ),
            ),
            onTap: () => _pesquisa(),
            controller: _controller,
          ),
        ),

        // actions: const [
        //   SizedBox(
        //     width: 65,
        //     height: 40,
        //     child: Icon(Icons.tune_outlined),
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        //Grid com os livros
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //Quantidade de itens lado a lado
            crossAxisSpacing: 4, //Espaçamento lateral
            mainAxisSpacing: 4, //Espaçamento vertical
          ),

          //A quantidade de livros na lista é o tamanho do "for"
          itemCount: livros.length,

          //chama a lista toda, um por vez (como num for) e coloca em algo (Card)
          itemBuilder: (context, index) => LivroCard(
            livro: livros[index],
          ),
        ),
      ),
    );
  }
}
