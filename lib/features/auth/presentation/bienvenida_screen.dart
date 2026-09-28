import 'package:flutter/material.dart';

import 'login_screen.dart';

class BienvenidaScreen extends StatelessWidget {
  const BienvenidaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 1.0,
              child: Image.network(
                'https://static.wikia.nocookie.net/mahouka-koukou-no-rettousei/images/4/41/Tatsuya%2C_and_First_High.png/revision/latest?cb=20141205203758&path-prefix=es', // <-- Puedes cambiar este enlace por la URL de tu imagen preferida
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: const Color.fromARGB(255, 253, 2, 2));
                },
              ),
            ),
          ),

          // 2. COLOR DE FONDO BASE (Por si la imagen no carga del todo)
          Container(
            color: const Color.fromARGB(255, 253, 2, 2).withOpacity(0.85),
          ),

          // 3. CONTENIDO PRINCIPAL DE LA PANTALLA
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.school,
                    size: 100,
                    color: Color.fromARGB(255, 9, 189, 159),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Gestión de Prácticas Preprofesionales',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 14, 13, 13),
                    ),
                  ),
                  const SizedBox(height: 19),
                  const Text(
                    'Controla tus horas, actividades y avances de forma digital.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(179, 58, 57, 57),
                    ),
                  ),
                  const SizedBox(height: 13),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 122, 100, 100),
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      // Navega a la pantalla de selección de usuario / login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Comenzar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
