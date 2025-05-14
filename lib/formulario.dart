import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();

  String? _genero;
  String? _estadoCivil;

  void _calcularEdad(DateTime fechaNacimiento) {
    final hoy = DateTime.now();
    int edad = hoy.year - fechaNacimiento.year;
    if (hoy.month < fechaNacimiento.month ||
        (hoy.month == fechaNacimiento.month && hoy.day < fechaNacimiento.day)) {
      edad--;
    }
    _edadController.text = edad.toString();
  }

  Future<void> _seleccionarFechaNacimiento() async {
    final DateTime? fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (fechaSeleccionada != null) {
      _fechaController.text = DateFormat('yyyy-MM-dd').format(fechaSeleccionada);
      _calcularEdad(fechaSeleccionada);
    }
  }

  void _enviarFormulario() {
    if (_formKey.currentState!.validate() &&
        _genero != null &&
        _estadoCivil != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulario válido y enviado correctamente')),
      );

      _formKey.currentState!.reset();
      _cedulaController.clear();
      _nombresController.clear();
      _apellidosController.clear();
      _fechaController.clear();
      _edadController.clear();

      setState(() {
        _genero = null;
        _estadoCivil = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
    }
  }

  void _salir() {
    Navigator.of(context).pop();
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.blueAccent),
      prefixIcon: Icon(icon, color: Colors.blueAccent),
      filled: true,
      fillColor: Colors.transparent,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.cyanAccent),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0B1E),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF101233),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Formulario",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    controller: _cedulaController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration("Cédula", Icons.badge),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Campo requerido';
                      if (value.length < 10) return 'Cédula inválida';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nombresController,
                    decoration: _inputDecoration("Nombres", Icons.person),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo requerido' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _apellidosController,
                    decoration: _inputDecoration("Apellidos", Icons.person_outline),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo requerido' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _fechaController,
                    readOnly: true,
                    decoration: _inputDecoration("Fecha de nacimiento", Icons.date_range),
                    style: const TextStyle(color: Colors.white),
                    onTap: _seleccionarFechaNacimiento,
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Selecciona una fecha' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _edadController,
                    readOnly: true,
                    decoration: _inputDecoration("Edad", Icons.numbers),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),

                  // GÉNERO CON ICONOS
                  Row(
                    children: [
                      const Icon(Icons.male, color: Colors.blueAccent),
                      Radio<String>(
                        value: 'Masculino',
                        groupValue: _genero,
                        onChanged: (value) => setState(() => _genero = value),
                      ),
                      const Text("Masculino", style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 20),
                      const Icon(Icons.female, color: Colors.pinkAccent),
                      Radio<String>(
                        value: 'Femenino',
                        groupValue: _genero,
                        onChanged: (value) => setState(() => _genero = value),
                      ),
                      const Text("Femenino", style: TextStyle(color: Colors.white)),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // ESTADO CIVIL CON ICONO
                  Row(
                    children: const [
                      Icon(Icons.favorite, color: Colors.redAccent),
                      SizedBox(width: 8),
                      Text("Estado Civil", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  RadioListTile<String>(
                    title: const Text("Soltero", style: TextStyle(color: Colors.white)),
                    value: 'Soltero',
                    groupValue: _estadoCivil,
                    onChanged: (value) => setState(() => _estadoCivil = value),
                    secondary: const Icon(Icons.person, color: Colors.blueAccent),
                  ),
                  RadioListTile<String>(
                    title: const Text("Casado", style: TextStyle(color: Colors.white)),
                    value: 'Casado',
                    groupValue: _estadoCivil,
                    onChanged: (value) => setState(() => _estadoCivil = value),
                    secondary: const Icon(Icons.group, color: Colors.greenAccent),
                  ),
                  RadioListTile<String>(
                    title: const Text("Viudo", style: TextStyle(color: Colors.white)),
                    value: 'Viudo',
                    groupValue: _estadoCivil,
                    onChanged: (value) => setState(() => _estadoCivil = value),
                    secondary: const Icon(Icons.person_off, color: Colors.grey),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _enviarFormulario,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ).copyWith(
                      backgroundColor: MaterialStateProperty.resolveWith((states) => null),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                    ),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00B4DB), Color(0xFF8E2DE2)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(minWidth: 150, minHeight: 45),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send, size: 20),
                            SizedBox(width: 8),
                            Text("Enviar", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: _salir,
                    icon: const Icon(Icons.exit_to_app, color: Colors.blueAccent),
                    label: const Text("Salir", style: TextStyle(color: Colors.blueAccent)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
