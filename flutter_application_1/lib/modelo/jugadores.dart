class Usuario {
  final String nombre;
  final String correo;

  Usuario({required this.nombre, required this.correo});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(nombre: json['nombre'] ?? '', correo: json['correo'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'nombre': nombre, 'correo': correo};
  }
}
