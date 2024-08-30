import 'package:aula_3/screens/Highlight.dart';
import 'package:aula_3/screens/drink_screen.dart';
import 'package:aula_3/screens/food_screen.dart';
import 'package:aula_3/themas/Appcolors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentpage = 0; //cria variavel para o buttom navigator
  static List<Widget> _widgetop=[
    Highlight(),
    Food_screen(),
    Drink_screen(),

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pannauci Restaurante"),
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant, // cor de fundo do appbar
        actions: <Widget>[
        Padding(padding: EdgeInsets.symmetric(horizontal: 16),
        child: Icon(Icons.account_circle),
        ),
        ],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: ((context){
          return const Home();
        })));
      }, child: Icon(Icons.point_of_sale),

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>
        [
        BottomNavigationBarItem(
            icon: Icon(Icons.stars),label: 'Destaques'),
          BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu),
          label: 'Menu'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.local_bar),
          label: 'drink'),
          
        ],
        selectedItemColor: AppColors.bottomNavigationBarIconColor, // muda a cor do item selecionado 
        currentIndex: _currentpage, //variavel do index conforme a seleção
        onTap:  (index) {
          setState(() {
            if(index>5){
              index=0;
            }
            _currentpage = index;

          });

        },

        ),
        body: Center(
          child: _widgetop.elementAt(_currentpage),
        ),
    );
  }
}