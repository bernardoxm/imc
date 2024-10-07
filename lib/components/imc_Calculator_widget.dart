import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:imc/components/start_buttom_widget.dart';
import 'package:imc/model/user_inf_model.dart';
import 'package:imc/pages/imc_login_page.dart';
import 'package:imc/pages/loading_page.dart';

class ImcCalculatorWidget extends StatefulWidget {
  final UserInfModel userInfModel;

  const ImcCalculatorWidget({super.key, required this.userInfModel});

  @override
  State<ImcCalculatorWidget> createState() => _ImcCalculatorWidgetState();
}

class _ImcCalculatorWidgetState extends State<ImcCalculatorWidget> {
  double calculateImc() {
 
    return widget.userInfModel.userkg /
        (widget.userInfModel.userHeight * widget.userInfModel.userHeight);

  
  }

  String getImcResult(double imc) {
    if (imc < 18.5) {
      return 'Underweight';
    } else if (imc >= 18.5 && imc < 24.9) {
      return 'Normal weight';
    } else if (imc >= 25 && imc < 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  // Função para calcular a gordura corporal com base no IMC, idade e gênero
  double calculateBodyFatPercentage(double imc, int age, String gender) {
    int genderFactor = (gender.toLowerCase() == 'male') ? 1 : 0;
    return 1.20 * imc + 0.23 * age - 10.8 * genderFactor - 5.4;
  }

  String getImageForGender(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return 'assets/male.png'; 
      case 'female':
        return 'assets/female.png'; 
      case 'non-binary':
        return 'assets/non_binary.png'; 
      case 'transgender':
        return 'assets/transgender.png'; 
      default:
        return 'assets/other.png'; 
    }
  }

  @override
  Widget build(BuildContext context) {
    double imc = calculateImc();
    String imcResult = getImcResult(imc);
    String imagePath = getImageForGender(widget.userInfModel.userGender);
    double bodyFatPercentage = calculateBodyFatPercentage(
        imc, widget.userInfModel.userAges, widget.userInfModel.userGender);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 36, 90, 236),
// Azul
      body: Center(
        child: Container(
          height: 800,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.userInfModel.userName,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                   fontWeight: FontWeight.bold,
                ),
              ),
              
              Stack(
                children: [
                  Image.asset(
                    imagePath,
                    width: 200,
                    height: 200,
                  ).animate().fadeIn(),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.userInfModel.userGender,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Exibindo os dados do usuário
                  Text(
                    'Age: ${widget.userInfModel.userAges}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ), 

              const SizedBox(height: 20),
              Text(
                'IMC: ${imc.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

             
              Text(
                imcResult,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              
              Text(
                'Body Fat: ${bodyFatPercentage.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImcLoginPage(
                        startButtomWidget: StartButtomWidget(
                          onPressed: () {},
                        ),
                      ),
                    ),
                  );
                }, // Chama a função passada
                child: const Text(
                  'Back',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(),
    );
  }
}
