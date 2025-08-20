import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'formulario_state.dart';

class FormularioCubit extends Cubit<FormularioState> {
  FormularioCubit() : super(FormularioInitial());

  Future<void> loadData() async {
    emit(FormularioCubitLoading());
    try {
      final response = await http.get(
        Uri.parse(
          "https://run.mocky.io/v3/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
        ),
      );
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        emit(FormularioCubitLoaded(json["data"] ?? "Sin datos"));
      } else {
        emit(FormularioCubitLoaded("Error en API Formulario ❌"));
      }
    } catch (e) {
      emit(FormularioCubitLoaded("Error: $e"));
    }
  }
}
