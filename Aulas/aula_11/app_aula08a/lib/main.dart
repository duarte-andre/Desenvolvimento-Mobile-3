import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_aula08a/models/models.dart';
import 'package:uuid/uuid.dart';
void main() async{
  //evita que de erro na tela
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // cria instancia do banco de dados
   // lista para armazenar os dados enviados ao firebase

  
  refresh()async{
      List<Lista>temp=[];
      QuerySnapshot<Map<String,dynamic>>snapshot = await firestore.collection("Listacompras").get();
      for(var doc in snapshot.docs){
        
        temp.add(Lista.fromMap(doc.data()));
        }
        setState(() {
          listLista=temp;
        });
    }
    List<Lista> listLista=[];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference produtos = FirebaseFirestore.instance.collection('Listacompras');
    // chama a atualização do banco de dados
    void remove(Lista model){
      firestore.collection("Listacompras").doc(model.id).delete();
      refresh();
    }
    @override
    void initState(){
      refresh();
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App aula 08"),
        backgroundColor: Colors.red,
      ),
      // botão flutuante
      floatingActionButton: FloatingActionButton(
        onPressed:
       (){
        showFormModal();
       },child: Icon(Icons.add),),
       body: (listLista.isEmpty)?Center(
        child: Text("Não temos nenhuma lista ! \n Vamos criar a primeira",
        style: TextStyle(fontSize: 18),),
        // refresh indicator atualiza a lista do app para exibi-la
       ):RefreshIndicator(
         onRefresh: (){
          return refresh();
         },
         child: ListView(
          children: List.generate(
              listLista.length, 
              (index){
              Lista model = listLista[index];
              // exclui um elemento da lista
              return Dismissible(
                key: ValueKey<Lista>(model),
                 onDismissed: (direction){
                  remove(model);
                },
                //key: UniqueKey(),
                 direction: DismissDirection.endToStart,
                 background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.delete),
                    ),
                    
                 ),
                 // onDismissed parametro que vai determinar quanto irei mover para excluir um item
                
                 child: ListTile(
                  onTap: (){
                    refresh();

                  },
                    onLongPress: (){
                    showFormModal(model: model);
                  },
                  leading: const Icon(Icons.list_alt_rounded),
                  title: Text(model.nome),
                  subtitle: Text(model.id),
               
                 ));
                 
                 
              },
              
              ) ,
         ),
         ),
    );
  }
  showFormModal({Lista? model}){
    // Labels a serem mostradas
    String title ="Adicionar lista";
    String confirmButton = "Salvar";
    String skipButton = "Cancelar";

    // Textediting controller
    TextEditingController nomecontroller = TextEditingController();
    if(model!=null){
      title = "Editando ${model.nome}";
      nomecontroller.text= model.nome;
    }


    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
         top: Radius.circular(24),
        ),
      ),
      builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height ,
          padding: const EdgeInsets.all(32),
          child: ListView(
            children: [
              Text(title,style: Theme.of(context).textTheme.displayLarge,),
              TextField(
                controller: nomecontroller,
                decoration: InputDecoration(
                  label: Text("Nome da lista"),

                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // botao cancelar
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                   child: Text(skipButton)),
                   SizedBox(
                    height: 16,
                   ),
                   ElevatedButton(
                    onPressed: ()async {
                      Lista compra = Lista(id: Uuid().v1(),
                      nome: nomecontroller.text);
                     if(model!=null){
                     compra.id = model.id;
                     }
                     firestore.collection("Listacompras").doc(compra.id).set(compra.toMap());

                     produtos.add({
                      'Nome':'TV',
                      'Valor':5000,
                      'Qtde':10
                     });
                     refresh();
                    
                    Navigator.pop(context);
                    }, child: Text(confirmButton)),
                     

                ],
              )
            ],
          ),
        );
      }
    );
  }

}

