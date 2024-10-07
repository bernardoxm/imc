import 'package:flutter/material.dart';
import 'package:imc/components/start_buttom_widget.dart';
import 'package:imc/pages/imc_login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 178, 198, 221)),
        useMaterial3: true,
      ),
      home: ImcLoginPage(startButtomWidget: StartButtomWidget(onPressed: () {  },)),
    );
  }
}


