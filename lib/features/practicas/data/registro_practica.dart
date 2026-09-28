class RegistroPractica {
  final int? id;
  final String estudianteId;
  final String empresaNombre;
  final String actividad;
  final String fecha;
  final double horasCumplidas;
  final String observacionSupervisor;
  final String estado; // 'registrado', 'observado', 'aprobado', 'rechazado'

  RegistroPractica({
    this.id,
    required this.estudianteId,
    required this.empresaNombre,
    required this.actividad,
    required this.fecha,
    required this.horasCumplidas,
    required this.observacionSupervisor,
    required this.estado,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'estudianteId': estudianteId,
      'empresaNombre': empresaNombre,
      'actividad': actividad,
      'fecha': fecha,
      'horasCumplidas': horasCumplidas,
      'observacionSupervisor': observacionSupervisor,
      'estado': estado,
    };
  }

  factory RegistroPractica.fromMap(Map<String, dynamic> map) {
    return RegistroPractica(
      id: map['id'],
      estudianteId: map['estudianteId'],
      empresaNombre: map['empresaNombre'],
      actividad: map['actividad'],
      fecha: map['fecha'],
      horasCumplidas: (map['horasCumplidas'] as num).toDouble(),
      observacionSupervisor: map['observacionSupervisor'] ?? '',
      estado: map['estado'],
    );
  }
}
