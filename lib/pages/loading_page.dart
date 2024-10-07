import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imc/model/user_inf_model.dart';
import 'package:imc/pages/result_page.dart';

class LoadingPage extends StatefulWidget {
  final UserInfModel userInfModel;

  // Construtor para receber o modelo de dados
  const LoadingPage({super.key, required this.userInfModel});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  bool _isLoading = true; // Controla o estado de carregamento

  @override
  void initState() {
    super.initState();

    // Simula o cálculo por 2 segundos e muda de tela ao fim
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });

      // Após 2 segundos, navega para a ResultPage passando o userInfModel
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResultPage(
            userInfModel: widget.userInfModel, // Passa o userInfModel preenchido
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 90, 236),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Hi,',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            // Exibindo o nome do usuário a partir do widget recebido
            Text(
              widget.userInfModel.userName,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'We prepared everything for you...',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            if (_isLoading) // Exibir o cálculo falso enquanto estiver carregando
              Column(
                children: [
                  const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Calculating...',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ],
              ).animate().fadeIn(),
          ],
        ),
      ),
    );
  }
}
