// Personaliza as cores do app
// cor do fundo, cor da fonte
import 'package:flutter/material.dart'; // importa o pacote material do flutter
// cria a classe app colors
class AppColors {
  static Color buttonForeground = Colors.white; // cor do botao
  static Color buttonBackground = const Color(0xFF6750A4); // cor do fundo do botao
  static Color drawerFontColor = const Color(0xFF49454F); // cor do drawer
  static Color drawerIconColor = const Color(0xFF1C1B1F); // cor do icone do drawer
  static Color counterButtonColor = const Color(0xFFCCB6DB); // cor do contador
  static Color? bottomNavigationBarIconColor = Colors.grey[800]; // cor do botton navigator
  static Color paymentMethodCardNumberColor = const Color(0xFF9C9C9C); // cor do metodo de pagamento
  static Color paymentMethodReceiptColor = const Color(0xFF9D9D9D);// metodo de recebimento

  // estilo do botao 
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(elevation: 0,
   foregroundColor: buttonForeground, backgroundColor: buttonBackground);
}



