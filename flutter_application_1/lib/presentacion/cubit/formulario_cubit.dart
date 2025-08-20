import 'package:bloc/bloc.dart';
import 'formulario_state.dart';

class FormularioCubit extends Cubit<FormularioState> {
  FormularioCubit() : super(FormularioInitial());

  Future<void> enviarDatos({
    required String correo,
    required String contrasena,
  }) async {
    emit(FormularioCubitLoading());

    await Future.delayed(const Duration(seconds: 2)); // simulamos petición

    // lógica simple: si el correo contiene "@" es éxito, sino fallo
    if (correo.contains('@') && contrasena.length >= 6) {
      emit(const FormularioCubitLoaded(mensaje: "Login exitoso ✅"));
    } else {
      emit(const FormularioFailure("Correo o contraseña inválidos ❌"));
    }
  }

  loadData() {}
}
