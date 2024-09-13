import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(title: 'App aula - 07 - Firebase'),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Instancia os controladores
  final TextEditingController nomeprod = TextEditingController();
  final TextEditingController qtde = TextEditingController();
  final TextEditingController valor = TextEditingController();

  // Instancia o Firestore
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Método para postar dados no Firestore
  void _postFireBase() {
    firestore.collection('Produtos').doc().set({
      "Nome": nomeprod.text,
      "Qtde": qtde.text,
      "Valor": valor.text,
    }).then((_) {
      // Limpa os campos após o envio bem-sucedido
      nomeprod.clear();
      qtde.clear();
      valor.clear();
      
      // Exibe um SnackBar com mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produto adicionado com sucesso!')),
      );
    }).catchError((error) {
      // Tratar erro se necessário
      print("Falha ao adicionar produto: $error");
      
      // Exibe um SnackBar com mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao adicionar produto.')),
      );
    });
  }

  // Método para printar o tamanho da tela
  void _printScreenSize() {
    final Size size = MediaQuery.of(context).size;
    print("Largura da tela: ${size.width}, Altura da tela: ${size.height}");
    
    // Exibe um SnackBar com o tamanho da tela (opcional)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Largura: ${size.width}, Altura: ${size.height}"),
      ),
    );
  }

  @override
  void dispose() {
    // Libera os recursos dos controladores quando o widget for removido
    nomeprod.dispose();
    qtde.dispose();
    valor.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    final width = mediaquery.width;
    final height = mediaquery.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(  // Adiciona rolagem se necessário
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("App Firebase", style: TextStyle(fontSize: 18)),
            SizedBox(
              width: double.infinity,  // Ajusta a largura do campo de texto para ocupar o máximo disponível
              child: TextFormField(
                controller: nomeprod,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Digite o nome do produto",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,  // Ajusta a largura do campo de texto para ocupar o máximo disponível
              child: TextFormField(
                controller: qtde,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Digite a quantidade do produto",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,  // Ajusta a largura do campo de texto para ocupar o máximo disponível
              child: TextFormField(
                controller: valor,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Digite o valor do produto",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _postFireBase,
              child: const Text("Enviar"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _printScreenSize,
              child: const Text("Imprimir Tamanho da Tela"),
            ),
          ],
        ),
      ),
    );
  }
}
