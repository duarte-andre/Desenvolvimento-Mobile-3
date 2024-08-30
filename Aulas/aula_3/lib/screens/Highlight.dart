import 'package:aula_3/cardapio.dart';
import 'package:aula_3/components/HIghlights_item.dart';
import 'package:flutter/material.dart';

class Highlight extends StatefulWidget {
  final List items = destaques;
  const Highlight({super.key});

  @override
  State<Highlight> createState() => _HighlightState();
}

class _HighlightState extends State<Highlight> {

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(16),
    child: ListView.builder(
      itemBuilder:(context,index){
        return Highlight_item(img: widget.items[index]["image"],
         nome: widget.items[index]["name"], price: widget.items[index]["price"], 
         description: widget.items[index]["description"]);
      },
      itemCount: widget.items.length,
      ),);
  }
}