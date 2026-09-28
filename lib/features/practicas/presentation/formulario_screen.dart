import 'package:flutter/material.dart';

import '../data/registro_practica.dart';
import '../../../core/database/database_helper.dart';

class FormularioScreen extends StatefulWidget {
  const FormularioScreen({super.key});

  @override
  State<FormularioScreen> createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _empresaController = TextEditingController();
  final _actividadController = TextEditingController();
  final _horasController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar Actividad Diaria')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _empresaController,
                decoration: const InputDecoration(
                  labelText: 'Empresa',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _actividadController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripción de la Actividad',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Campo obligatorio' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _horasController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Horas Cumplidas',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Ingrese un número válido de horas';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final nuevo = RegistroPractica(
                      estudianteId: 'EST-001',
                      empresaNombre: _empresaController.text,
                      actividad: _actividadController.text,
                      fecha: DateTime.now().toIso8601String().split('T')[0],
                      horasCumplidas: double.parse(_horasController.text),
                      observacionSupervisor: 'Sin observaciones',
                      estado: 'registrado',
                    );

                    await DatabaseHelper.instance.insertRegistro(nuevo);

                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('¡Actividad guardada localmente!'),
                      ),
                    );
                    Navigator.pop(context, true);
                  }
                },
                child: const Text('Guardar Registro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
