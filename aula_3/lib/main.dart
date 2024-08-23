import 'package:aula_3/screens/Home.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const PannuciRestaurante());
}

class PannuciRestaurante extends StatefulWidget {
  const PannuciRestaurante({super.key});

  @override
  State<PannuciRestaurante> createState() => _PannuciRestauranteState();
}

class _PannuciRestauranteState extends State<PannuciRestaurante> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Colors.purple,useMaterial3: true),
      home: Home(),
    );
  }
}