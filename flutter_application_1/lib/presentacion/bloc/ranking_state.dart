import 'package:flutter_application_1/modelo/jugadores.dart';

abstract class RankingState {}

class RankingInitial extends RankingState {}

class RankingBlocLoading extends RankingState {}

class RankingBlocLoaded extends RankingState {
  final List<Jugador> jugadores;
  RankingBlocLoaded(this.jugadores);
}
