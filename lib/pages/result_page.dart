import 'package:flutter/material.dart';
import 'package:imc/components/imc_Calculator_widget.dart';
import 'package:imc/model/user_inf_model.dart';

class ResultPage extends StatelessWidget {
  final UserInfModel userInfModel; // Recebe o modelo preenchido

  const ResultPage({super.key, required this.userInfModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 106, 255),
      body: ImcCalculatorWidget(
        userInfModel: userInfModel, // Passa o modelo para o widget
      ),
    );
  }
}
