import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Necessário para usar TextInputFormatter

import 'package:imc/model/user_inf_model.dart';
import 'package:imc/pages/loading_page.dart';

class TextimputWidget extends StatefulWidget {
  const TextimputWidget({super.key});

  @override
  State<TextimputWidget> createState() => _TextimputWidgetState();
}

class _TextimputWidgetState extends State<TextimputWidget> {
  // Controladores para capturar dados do TextField
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      child: Column(
        children: [
         
          _buildTextField(_nameController, 'Name'),
          SizedBox(height: 20),

       
          _buildTextField(_ageController, 'Age', keyboardType: TextInputType.number),
          SizedBox(height: 20),

          
          _buildTextField(
            _heightController,
            'Height (m)',
            keyboardType: TextInputType.number,
            inputFormatters: [_HeightInputFormatter()], // Formatter para altura
          ),
          SizedBox(height: 20),

          // Campo de peso (em kg)
          _buildTextField(_weightController, 'Weight (kg)', keyboardType: TextInputType.number),
          SizedBox(height: 20),

          // Campo de gênero
          SizedBox(
            height: 60,
            width: 380,
            child: DropdownButtonFormField<String>(
              value: _selectedGender,
              items: ['Male', 'Female', 'Non-binary', 'Prefer not to say', 'Other']
                  .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
              decoration: InputDecoration(
             
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // Define o raio da borda
                  borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 1), // Cor e largura da borda
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 2), // Cor da borda ativa
                ),
               
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: const Color.fromARGB(255, 255, 255, 255), width: 1),
                ),
                filled: true, 
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
               hintText: 'Select Gender',
              ),
              
            ),
          ),
          SizedBox(height: 20),

          // Botão para processar os dados
          ElevatedButton(
            onPressed: () {
              _submitForm();

              // Verifica se os campos foram preenchidos corretamente
              if (_nameController.text.isNotEmpty &&
                  _ageController.text.isNotEmpty &&
                  _heightController.text.isNotEmpty &&
                  _weightController.text.isNotEmpty &&
                  _selectedGender != null) {
                
                // Cria o UserInfModel com os dados preenchidos
                UserInfModel user = UserInfModel(
                  userName: _nameController.text,
                  userAges: int.parse(_ageController.text),
                  userHeight: double.parse(_heightController.text.replaceAll(',', '.')),
                  userkg: double.parse(_weightController.text),
                  userGender: _selectedGender!,
                );

                // Navega para a LoadingPage passando o modelo criado
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoadingPage(userInfModel: user),
                  ),
                );
              } else {
                // Caso os campos não estejam preenchidos, exibe uma mensagem de erro
                print('Please fill out all fields');
              }
            },
            child: Text(
              'Next',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
            ),
          ),
          SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText,
      {TextInputType keyboardType = TextInputType.text, List<TextInputFormatter>? inputFormatters}) {
    return Container(
      width: 380,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintText: hintText,
        ),
      ),
    );
  }

  // Função para processar o formulário
  void _submitForm() {
    final String name = _nameController.text;
    final int? age = int.tryParse(_ageController.text);
    final double? height = double.tryParse(_heightController.text.replaceAll(',', '.')); // Substitui vírgula por ponto, se necessário
    final double? weight = double.tryParse(_weightController.text);

    if (name.isNotEmpty && age != null && height != null && weight != null && _selectedGender != null) {
      // Cria o modelo de dados do usuário
      UserInfModel user = UserInfModel(
        userName: name,
        userAges: age,
        userHeight: height,
        userkg: weight,
        userGender: _selectedGender!,
      );

     
      print('User Info: ${user.userName}, ${user.userAges}, ${user.userHeight} m, ${user.userkg} kg, ${user.userGender}');
    } else {
  
      print('Please fill out all fields');
    }
  }
}


class _HeightInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;

  
    if (text.length == 1 && text != '1' && !text.contains('.')) {
      text += '.';
    } else if (text.length == 2 && !text.contains('.')) {
      text = text.substring(0, 1) + '.' + text.substring(1);
    }

   
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
