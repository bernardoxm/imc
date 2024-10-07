import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:flutter_animate/flutter_animate.dart';


class GifWidget extends StatelessWidget {
  const GifWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Image.asset("assets/gif/doctorGif.gif").animate().fadeIn(), // Certifique-se que o caminho do GIF está correto
          Text(
            'Body Mass Index', // Corrigi o texto "ndex" para "Index"
            style: GoogleFonts.montserrat( // Use a fonte Montserrat
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 255, 255, 255), // Cor pode ser ajustada conforme necessário
              ),
            ),
          ),
          SizedBox(
            height: 20, // Espaçamento entre o texto e outros elementos
          ),
        ],
      ),
    );
  }
}
