import 'package:aula_3/screens/Home.dart';
import 'package:aula_3/themas/Appcolors.dart';
import 'package:flutter/material.dart';

class MainDrawer_item extends StatelessWidget {
  const MainDrawer_item({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      child: ListView(
        children: [
          ListTile(
            title: Text("Mesa 03", style: TextStyle(fontSize: 16,
            color: AppColors.drawerFontColor,
            fontWeight: FontWeight.w900),),

          ),
          ListTile(
            textColor: AppColors.drawerFontColor,
            title: Text("Conta", style: TextStyle(fontWeight: FontWeight.w500))
            
          ),
          ListTile(iconColor: AppColors.drawerIconColor,
          onTap: () {
            Navigator.push(context,
            MaterialPageRoute(builder: (context){
              return Home();
            }),
            );
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Icon(Icons.receipt_long),
            Expanded(
              child: 
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text("Pedido atual", style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
                ),
                ),),
                Text("+ 100", style: TextStyle(fontWeight: FontWeight.w700),),
          ],
          ),
          ),
          ListTile(
            iconColor: AppColors.drawerIconColor,
            textColor: AppColors.drawerFontColor,
            onTap: (){

            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon)
              ],
            ),
          )
        ],
      ),
    );
  }
}