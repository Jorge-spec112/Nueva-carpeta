import 'dart:convert';
import 'package:flutter_application_1/modelo/jugadores.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'ranking_event.dart';
import 'ranking_state.dart';

class RankingBloc extends Bloc<RankingEvent, RankingState> {
  RankingBloc() : super(RankingInitial()) {
    on<LoadBlocEvent>(_onLoad);
  }

  Future<void> _onLoad(LoadBlocEvent event, Emitter<RankingState> emit) async {
    emit(RankingBlocLoading());
    try {
      final response = await http.get(
        Uri.parse(
          "https://run.mocky.io/v3/7b453a37-f9cb-4657-8719-4d83e43ad5e3", // URL de Mocky
        ),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<dynamic> list = json["jugadores"] ?? [];
        final jugadores = list.map((e) => Jugador.fromJson(e)).toList();
        emit(RankingBlocLoaded(jugadores));
      } else {
        emit(RankingBlocLoaded([])); // vacío si error
      }
    } catch (e) {
      emit(RankingBlocLoaded([]));
    }
  }
}
