import 'package:aula_3/cardapio.dart';
import 'package:aula_3/components/drink.dart';
import 'package:flutter/material.dart';

class Drink_screen extends StatelessWidget {
  final List items = drinks;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    
    itemBuilder:(context,index){
      return DrinkItem(imageURI: items[index]['image'], itemPrice: items[index]['price'], itemTitle: items[index]['name']);
    
    },
    itemCount: items.length,
    );
  }
}