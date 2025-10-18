import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'formulario.dart'; // importa tu formulario

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Formulario Registro',
      theme: ThemeData.dark(), // puedes cambiar a light() si deseas fondo rosado
      home: const FormularioScreen(),
      
      // 👇 ESTO ES LO IMPORTANTE
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'ES'), // español
        Locale('en', 'US'), // inglés (opcional)
      ],
    );
  }
}
