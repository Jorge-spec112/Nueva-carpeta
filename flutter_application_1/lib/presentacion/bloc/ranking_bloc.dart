import 'dart:convert';
import 'package:flutter_application_1/modelo/jugadores.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'ranking_event.dart';
import 'ranking_state.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  RankingBloc() : super(RankingBlocInitial()) {
    on<LoadBlocEvent>(_onLoadUsuarios);
  }

  Future<void> _onLoadUsuarios(
    LoadBlocEvent event,
    Emitter<RankingState> emit,
  ) async {
    emit(RankingBlocLoading());

    try {
      final response = await http.get(
        Uri.parse("https://jsonkeeper.com/b/KDGZM"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        final usuarios = data
            .map((e) => Usuario.fromJson(e as Map<String, dynamic>))
            .toList();

        emit(RankingBlocLoaded(usuarios: usuarios));
      } else {
        emit(RankingBlocFailure("Error al cargar usuarios"));
      }
    } catch (e) {
      emit(RankingBlocFailure("Excepción: $e"));
    }
  }
}
