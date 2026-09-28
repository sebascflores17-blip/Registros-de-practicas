import 'package:flutter/material.dart';

import '../../dashboard/presentation/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  String _rolSeleccionado = 'Estudiante Practicante';

  final List<String> _roles = [
    'Estudiante Practicante',
    'Tutor Académico',
    'Supervisor de Empresa',
    'Coordinador de Prácticas',
  ];

  void _ingresar() {
    if (_userController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor ingresa tu nombre o usuario')),
      );
      return;
    }

    // Redirige al Menú Principal (Dashboard)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: const Color.fromARGB(255, 255, 0, 0),
      ),
      body: Stack(
        children: [
          // 1. IMAGEN DE FONDO EN LÍNEA (MARCA DE AGUA MÁS VISIBLE)
          Positioned.fill(
            child: Opacity(
              opacity: 0.90, // Subido a 0.30 para que se note más
              child: Image.network(
                'https://m.media-amazon.com/images/M/MV5BZTNmZWI3ZWYtNjkzYi00ZTFkLWI0MzctMjc2YzlmNGRkNzRiXkEyXkFqcGc@._V1_FMjpg_UX1000_.jpg', // <-- Puedes cambiar este enlace por la URL que prefieras
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color.fromARGB(255, 124, 124, 124),
                  );
                },
              ),
            ),
          ),

          // 2. CONTENIDO PRINCIPAL DE LA PANTALLA
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person_pin,
                      size: 80,
                      color: Color.fromARGB(255, 255, 68, 68),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Identificación de Usuario',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _userController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre o Código de Usuario',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                        filled: true,
                        fillColor: Color.fromARGB(
                          179,
                          148,
                          144,
                          144,
                        ), // Fondo semitransparente para que resalte el texto
                      ),
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _rolSeleccionado,
                      decoration: const InputDecoration(
                        labelText: 'Seleccionar Rol',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.badge),
                        filled: true,
                        fillColor: Color.fromARGB(179, 150, 147, 147),
                      ),
                      items: _roles.map((String rol) {
                        return DropdownMenuItem<String>(
                          value: rol,
                          child: Text(rol),
                        );
                      }).toList(),
                      onChanged: (String? nuevoRol) {
                        if (nuevoRol != null) {
                          setState(() {
                            _rolSeleccionado = nuevoRol;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _ingresar,
                        child: const Text(
                          'Ingresar a la App',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
