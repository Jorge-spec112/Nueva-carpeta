import 'package:flutter_application_1/modelo/jugadores.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    await Future.delayed(const Duration(seconds: 2));

    final usuarios = [
      Usuario(nombre: "Jorge", correo: "jorge@gmail.com"),
      Usuario(nombre: "Paula", correo: "paula@gmail.com"),
      Usuario(nombre: "Andrea", correo: "andrea@gmail.com"),
      Usuario(nombre: "Carlos", correo: "carlos@gmail.com"),
    ];

    emit(RankingBlocLoaded(usuarios: usuarios));
  }
}
