import 'package:flutter/material.dart';

import '../../../core/database/database_helper.dart';
import '../data/registro_practica.dart';
import 'detalle_screen.dart'; // <-- Importación necesaria para abrir la pantalla de detalle

class ListadoScreen extends StatefulWidget {
  const ListadoScreen({super.key});

  @override
  State<ListadoScreen> createState() => _ListadoScreenState();
}

class _ListadoScreenState extends State<ListadoScreen> {
  late Future<List<RegistroPractica>> _listaRegistros;

  @override
  void initState() {
    super.initState();
    _cargarRegistros();
  }

  void _cargarRegistros() {
    setState(() {
      _listaRegistros = DatabaseHelper.instance.getRegistros();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Prácticas'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<RegistroPractica>>(
        future: _listaRegistros,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No hay registros guardados todavía.\n¡Crea uno desde el menú principal!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            );
          }

          final registros = snapshot.data!;

          return ListView.builder(
            itemCount: registros.length,
            itemBuilder: (context, index) {
              final reg = registros[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    reg.empresaNombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${reg.actividad}\nHoras: ${reg.horasCumplidas} | Estado: ${reg.estado}',
                  ),
                  isThreeLine: true,
                  onTap: () async {
                    // Abre la pantalla de detalle/edición al hacer clic en la tarjeta
                    final actualizado = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalleScreen(registro: reg),
                      ),
                    );
                    // Si se guardaron cambios, recarga la lista automáticamente
                    if (actualizado == true) {
                      _cargarRegistros();
                    }
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      if (reg.id != null) {
                        await DatabaseHelper.instance.deleteRegistro(reg.id!);
                        _cargarRegistros(); // Recarga la lista al borrar
                        if (!mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Registro eliminado con éxito'),
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
