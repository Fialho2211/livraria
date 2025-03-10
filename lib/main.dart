import 'package:flutter/material.dart';
import 'package:livraria/biblioteca/biblioteca.dart';
import 'package:livraria/biblioteca/views/alterar_senha.dart';
import 'package:livraria/login/login.dart';
import 'package:livraria/login/widgets/cadastro.dart';
import 'package:livraria/login/widgets/esqueceu_senha.dart';
import 'package:livraria/model/classes/usuario.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    //Usando o provider é possível avisar toda Livraria quando houver
    //mudanças na classe Usuário
    ChangeNotifierProvider(
      create: (context) =>
          Usuario(nome: '', email: '', telefone: '', senha: ''),
      child: const LivrariaApp(),
    ),
  );
}

class LivrariaApp extends StatelessWidget {
  const LivrariaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Livraria',
      debugShowCheckedModeBanner: false, //Tira a tarja "Debug"
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.lightBlue,
      ),
      initialRoute: '/', //Rota inicial
      routes: {
        '/': (context) => const Login(),
        '/esqueceu_senha': (context) => const EsqueceuSenha(),
        '/alterar_senha': (context) => const AlterarSenha(),
        '/cadastro': (context) => const Cadastro(),
        '/biblioteca': (context) => const Biblioteca(),
      },
    );
  }
}
