import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de texto
  final TextEditingController _controlController = TextEditingController();
  final TextEditingController _curpController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoPaternoController = TextEditingController();
  final TextEditingController _apellidoMaternoController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variables de estado
  String? _genero;
  String _estadoSeleccionado = "Aguascalientes";

  // Fecha (día, mes, año)
  DateTime _fechaSeleccionada = DateTime(1950, 1, 1);

  void _seleccionarFecha(BuildContext context) async {
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('es', 'ES'),
    );
    if (fecha != null) {
      setState(() {
        _fechaSeleccionada = fecha;
      });
    }
  }

  void _generarCURP() {
    if (_nombreController.text.isEmpty ||
        _apellidoPaternoController.text.isEmpty ||
        _apellidoMaternoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa nombre y apellidos antes de generar CURP')),
      );
      return;
    }

    setState(() {
      _curpController.text =
          "${_apellidoPaternoController.text.substring(0, 2).toUpperCase()}${_apellidoMaternoController.text.substring(0, 1).toUpperCase()}${_nombreController.text.substring(0, 2).toUpperCase()}${_fechaSeleccionada.year}";
    });
  }

  void _guardarFormulario() {
    if (_formKey.currentState!.validate() && _genero != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos guardados correctamente')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa todos los campos requeridos')),
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
                    "Registro de Usuario",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Nº CONTROL
                  TextFormField(
                    controller: _controlController,
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration("N° Control", Icons.badge),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo requerido' : null,
                  ),
                  const SizedBox(height: 16),

                  // CURP + BOTÓN
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _curpController,
                          decoration: _inputDecoration("CURP", Icons.credit_card),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Campo requerido' : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: _generarCURP,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Generar"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // NOMBRES
                  TextFormField(
                    controller: _nombreController,
                    decoration: _inputDecoration("Nombre(s)", Icons.person),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo requerido' : null,
                  ),
                  const SizedBox(height: 16),

                  // APELLIDOS
                  TextFormField(
                    controller: _apellidoPaternoController,
                    decoration: _inputDecoration("Apellido Paterno", Icons.person_outline),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo requerido' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _apellidoMaternoController,
                    decoration: _inputDecoration("Apellido Materno", Icons.person_outline),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 16),

                  // USUARIO Y PASSWORD
                  TextFormField(
                    controller: _usuarioController,
                    decoration: _inputDecoration("Usuario", Icons.account_circle),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo requerido' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: _inputDecoration("Password", Icons.lock),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Campo requerido' : null,
                  ),
                  const SizedBox(height: 16),

                  // GÉNERO
                  Row(
                    children: [
                      const Text("Género:", style: TextStyle(color: Colors.white)),
                      const SizedBox(width: 12),
                      Radio<String>(
                        value: 'Femenino',
                        groupValue: _genero,
                        onChanged: (value) => setState(() => _genero = value),
                      ),
                      const Text("Femenino", style: TextStyle(color: Colors.white)),
                      Radio<String>(
                        value: 'Masculino',
                        groupValue: _genero,
                        onChanged: (value) => setState(() => _genero = value),
                      ),
                      const Text("Masculino", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // FECHA
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Fecha: ${DateFormat('dd / MMMM / yyyy').format(_fechaSeleccionada)}",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _seleccionarFecha(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Seleccionar"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ESTADO
                  DropdownButtonFormField<String>(
                    value: _estadoSeleccionado,
                    dropdownColor: const Color(0xFF101233),
                    items: const [
                      DropdownMenuItem(value: "Aguascalientes", child: Text("Aguascalientes")),
                      DropdownMenuItem(value: "Baja California", child: Text("Baja California")),
                      DropdownMenuItem(value: "Chiapas", child: Text("Chiapas")),
                      DropdownMenuItem(value: "Jalisco", child: Text("Jalisco")),
                      DropdownMenuItem(value: "CDMX", child: Text("Ciudad de México")),
                    ],
                    onChanged: (value) => setState(() => _estadoSeleccionado = value!),
                    style: const TextStyle(color: Colors.white),
                    decoration: _inputDecoration("Estado", Icons.map),
                  ),

                  const SizedBox(height: 32),

                  // BOTONES
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _guardarFormulario,
                        icon: const Icon(Icons.save),
                        label: const Text("Guardar"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent[400],
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _salir,
                        icon: const Icon(Icons.exit_to_app),
                        label: const Text("Salir"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
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
