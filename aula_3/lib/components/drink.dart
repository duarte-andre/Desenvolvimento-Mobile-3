import 'package:flutter/material.dart';

class DrinkItem extends StatelessWidget {
  const DrinkItem(
    {Key? key,
    required this.imageURI,
    required this.itemPrice,
    required this.itemTitle})
    : super(key: key);
    final String imageURI;
    final String itemPrice;
    final String itemTitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      color: Theme.of(context).colorScheme.surfaceVariant,
      elevation: 0,
      child: Column(
        children: <Widget>[
          Image(
            height: 90,
            width: double.infinity,
            image: AssetImage(imageURI),
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  itemTitle,
                  style: const TextStyle(fontSize: 16),
                ),
                Text("R\$" + itemPrice),
              ],
            ),
          )
        ],
      ),
    );
  }
}