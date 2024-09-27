  import 'package:flutter/material.dart'; // Importa a biblioteca Flutter para widgets
  import 'package:firebase_core/firebase_core.dart'; // Importa a inicialização do Firebase
  import 'firebase_options.dart'; // Configurações específicas do Firebase
  import 'package:cloud_firestore/cloud_firestore.dart'; // Importa Firestore para interagir com o banco de dados
  import 'package:app_aula08a/models/models.dart'; // Importa os modelos de dados, como a classe Lista
  import 'package:uuid/uuid.dart'; // Importa para gerar identificadores únicos

  void main() async {
    // Garante que os widgets do Flutter estejam prontos para inicialização assíncrona
    WidgetsFlutterBinding.ensureInitialized();
    // Inicializa o Firebase com as opções da plataforma atual
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Executa o aplicativo com a tela inicial Home
    runApp(MaterialApp(
      home: Home(),
    ));
  }

  class Home extends StatefulWidget {
    const Home({super.key}); // Construtor da classe Home

    @override
    State<Home> createState() => _HomeState(); // Cria o estado correspondente
  }

  class _HomeState extends State<Home> {
    // Lista temporária para armazenar os dados recebidos do Firestore
 
    // Lista que será exibida na tela
    List<Lista> listLista = [];
    // Instância do Firestore para operações no banco de dados
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Método para atualizar a lista de compras
    refresh() async {
         List<Lista> temp = [];
      // Obtém todos os documentos da coleção "Listacompras"
      QuerySnapshot<Map<String, dynamic>> snapshot = await firestore.collection("Listacompras").get();
      for (var doc in snapshot.docs) {
        // Adiciona cada documento à lista temporária após converter para o modelo Lista
        temp.add(Lista.fromMap(doc.data()));
      }
      // Atualiza o estado da tela com os novos dados
      setState(() {
        listLista = temp;
      });
    }

    void remove(Lista model){
      firestore.collection("Listacompras").doc(model.id).delete();
      refresh();
    }

    @override
    void initState() {
      // Chama refresh para carregar os dados do Firestore na inicialização
      refresh();
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("App aula 08"), // Título do aplicativo
          backgroundColor: Colors.red, // Cor de fundo da AppBar
        ),
        // Botão flutuante para adicionar uma nova lista
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showFormModal(); // Abre o modal para adicionar uma nova lista
          },
          child: Icon(Icons.add),
        ),
        body: (listLista.isEmpty) // Verifica se a lista está vazia
            ? Center(
                child: Text(
                  "Não temos nenhuma lista ! \n Vamos criar a primeira",
                  style: TextStyle(fontSize: 18), // Mensagem exibida se não houver listas
                ),
              )
            : RefreshIndicator(
                // Permite atualizar a lista puxando para baixo
                onRefresh: () {
                  return refresh(); // Chama refresh ao atualizar
                },
                child: ListView(
                  children: List.generate(
                    listLista.length, (index) {
                      Lista model = listLista[index]; // Obtém o modelo da lista atual
                      return Dismissible(
                        key: ValueKey<Lista>(model), // Chave única para identificar o item
                        direction: DismissDirection.endToStart, // Direção do deslizar
                        background: Container(
                          color: Colors.red, // Cor do fundo ao deslizar
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.delete), // Ícone de excluir
                          ),
                        ),
                        onDismissed: (direction) {
                          // Ação a ser tomada ao deslizar o item (exclusão não implementada)
                        },
                        child: ListTile(
                          onTap: () {
                            // Ação ao tocar no item (não implementada)
                          },
                          onLongPress: () {
                            showFormModal(model: model); // Abre o modal para editar o item
                          },
                          leading: const Icon(Icons.list_alt_rounded), // Ícone à esquerda do item
                          title: Text(model.nome), // Nome da lista
                          subtitle: Text(model.id), // ID da lista
                        ),
                      );
                    },
                  ),
                ),
              ),
      );
    }

    // Método para exibir o modal para adicionar ou editar uma lista
    showFormModal({Lista? model}) {
      String title = "Adicionar lista"; // Título padrão do modal
      String confirmButton = "Salvar"; // Texto do botão de confirmação
      String skipButton = "Cancelar"; // Texto do botão de cancelamento

      TextEditingController nomecontroller = TextEditingController(); // Controlador para o campo de texto
      if (model != null) {
        title = "Editando ${model.nome}"; // Atualiza o título se estiver editando
        nomecontroller.text = model.nome; // Preenche o campo com o nome existente
      }

      // Exibe o modal na parte inferior da tela
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24), // Arredonda a parte superior do modal
          ),
        ),
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(32),
            child: ListView(
              children: [
                Text(title, style: Theme.of(context).textTheme.displayLarge), // Título do modal
                TextField(
                  controller: nomecontroller, // Controlador do campo de texto
                  decoration: InputDecoration(
                    label: Text("Nome da lista"), // Rótulo do campo
                  ),
                ),
                SizedBox(height: 16), // Espaço entre os elementos
                Row(
                  mainAxisAlignment: MainAxisAlignment.end, // Alinha os botões à direita
                  children: [
                    // Botão para cancelar a operação
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Fecha o modal
                      },
                      child: Text(skipButton),
                    ),
                    SizedBox(height: 16), // Espaço entre os botões
                    ElevatedButton(
                      onPressed: () async {
                        // Cria um novo objeto Lista com ID único
                        Lista compra = Lista(id: Uuid().v1(), nome: nomecontroller.text);
                        if (model != null) {
                          compra.id = model.id; // Mantém o ID se estiver editando
                        }
                        // Salva o item no Firestore
                        firestore.collection("Listacompras").doc(compra.id).set(compra.toMap());
                        refresh(); // Atualiza a lista
                        Navigator.pop(context); // Fecha o modal
                      },
                      child: Text(confirmButton), // Texto do botão de salvar
                    ),
                  ],
                )
              ],
            ),
          );
        },
      );
    }
  }
