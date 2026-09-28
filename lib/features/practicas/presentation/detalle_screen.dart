import 'package:flutter/material.dart';

import '../../../core/database/database_helper.dart';
import '../data/registro_practica.dart';

class DetalleScreen extends StatefulWidget {
  final RegistroPractica registro;

  const DetalleScreen({super.key, required this.registro});

  @override
  State<DetalleScreen> createState() => _DetalleScreenState();
}

class _DetalleScreenState extends State<DetalleScreen> {
  late TextEditingController _empresaController;
  late TextEditingController _actividadController;
  late TextEditingController _horasController;
  late TextEditingController _observacionController;
  late String _estadoActual;

  final List<String> _estados = [
    'Registrado',
    'Observado',
    'Aprobado',
    'Rechazado',
  ];

  @override
  void initState() {
    super.initState();
    _empresaController = TextEditingController(
      text: widget.registro.empresaNombre,
    );
    _actividadController = TextEditingController(
      text: widget.registro.actividad,
    );
    _horasController = TextEditingController(
      text: widget.registro.horasCumplidas.toString(),
    );
    _observacionController = TextEditingController(
      text: widget.registro.observacionSupervisor,
    );
    _estadoActual = _estados.contains(widget.registro.estado)
        ? widget.registro.estado
        : 'Registrado';
  }

  @override
  void dispose() {
    _empresaController.dispose();
    _actividadController.dispose();
    _horasController.dispose();
    _observacionController.dispose();
    super.dispose();
  }

  Future<void> _actualizarRegistro() async {
    // Convertimos a double ya que tu modelo maneja horasCumplidas como double
    final horas = double.tryParse(_horasController.text) ?? 0.0;

    final registroActualizado = RegistroPractica(
      id: widget.registro.id,
      estudianteId:
          widget.registro.estudianteId, // Coincide exactamente con tu modelo
      empresaNombre: _empresaController.text,
      actividad: _actividadController.text,
      fecha: widget.registro.fecha,
      horasCumplidas: horas,
      observacionSupervisor: _observacionController.text,
      estado: _estadoActual,
    );

    await DatabaseHelper.instance.updateRegistro(registroActualizado);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('¡Registro actualizado con éxito!')),
    );
    Navigator.pop(context, true); // Regresa al listado y lo actualiza
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle y Edición de Práctica'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _empresaController,
              decoration: const InputDecoration(
                labelText: 'Empresa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _actividadController,
              decoration: const InputDecoration(
                labelText: 'Actividad Realizada',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _horasController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Horas Cumplidas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _observacionController,
              decoration: const InputDecoration(
                labelText: 'Observación del Supervisor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _estadoActual,
              decoration: const InputDecoration(
                labelText: 'Estado',
                border: OutlineInputBorder(),
              ),
              items: _estados.map((String estado) {
                return DropdownMenuItem<String>(
                  value: estado,
                  child: Text(estado),
                );
              }).toList(),
              onChanged: (String? nuevoEstado) {
                if (nuevoEstado != null) {
                  setState(() {
                    _estadoActual = nuevoEstado;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: _actualizarRegistro,
              icon: const Icon(Icons.save),
              label: const Text(
                'Guardar Cambios',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
