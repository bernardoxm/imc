import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imc/components/gif_widget.dart';
import 'package:imc/components/start_buttom_widget.dart';
import 'package:imc/components/textImput_widget.dart';

class ImcLoginPage extends StatefulWidget {
  const ImcLoginPage({super.key, required StartButtomWidget startButtomWidget});

  @override
  _ImcLoginPageState createState() => _ImcLoginPageState();
}

class _ImcLoginPageState extends State<ImcLoginPage> {
  bool startbt = false; // Controle do estado do botão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 90, 236),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              
              height:800,
              width: 400,

              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GifWidget().animate().fadeIn(),
                  if (!startbt)
                    StartButtomWidget(
                      onPressed: () {
                        setState(() {
                          startbt = true; // Atualiza o estado para mostrar o próximo widget
                        });
                      },
                    ).animate().fadeIn(),
                  if (startbt) TextimputWidget().animate().fadeIn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
