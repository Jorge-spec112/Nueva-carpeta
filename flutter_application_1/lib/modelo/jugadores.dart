class Jugador {
  final String nombre;
  final int puntaje;

  Jugador({required this.nombre, required this.puntaje});

  factory Jugador.fromJson(Map<String, dynamic> json) {
    return Jugador(
      nombre: json['nombre'] ?? 'Sin nombre',
      puntaje: json['puntaje'] ?? 0,
    );
  }
}
