import 'package:bloc/bloc.dart';
import 'formulario_state.dart';

class FormularioCubit extends Cubit<FormularioState> {
  FormularioCubit() : super(FormularioInitial());

  Future<void> loadData() async {
    emit(FormularioCubitLoading());

    // simulamos un delay de 2 segundos
    await Future.delayed(const Duration(seconds: 2));

    // luego marcamos como cargado
    emit(FormularioCubitLoaded(mensaje: "Formulario listo ✅"));
  }
}
