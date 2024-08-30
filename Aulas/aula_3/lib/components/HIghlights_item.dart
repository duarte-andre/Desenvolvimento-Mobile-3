import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Highlight_item extends StatelessWidget {
  
  final String img;
  final String nome;
  final String price;
  final String description;
    Highlight_item({Key?key, required this.img,required this.nome,
    required this.price,required this.description}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).colorScheme.surfaceVariant,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image(image: AssetImage(img), fit: BoxFit.cover,), //box determina o preenchimento da imagem
          Padding(padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(nome,style: TextStyle(fontSize: 16),),
              Text("R \$ ${price}",style: TextStyle(fontSize: 16),),
              Padding(padding: EdgeInsets.symmetric(vertical: 8), 
              child:Text(description),),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(onPressed:(){

              },child: Text("Pedir"),),
              )
            ],
          ),
          ),
          
        ],
      ),
    );
  }
}