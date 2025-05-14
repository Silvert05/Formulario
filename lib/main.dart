import 'package:flutter/material.dart';
import 'formulario.dart'; // Asegúrate de que el nombre del archivo sea correcto

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const FormularioScreen(),
    );
  }
}
