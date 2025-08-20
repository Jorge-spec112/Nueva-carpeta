import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/modelo/jugadores.dart';

abstract class RankingState extends Equatable {
  const RankingState();

  @override
  List<Object?> get props => [];
}

class RankingBlocInitial extends RankingState {}

class RankingBlocLoading extends RankingState {}

class RankingBlocLoaded extends RankingState {
  final List<Usuario> usuarios;

  const RankingBlocLoaded({required this.usuarios});

  @override
  List<Object?> get props => [usuarios];
}

class RankingBlocFailure extends RankingState {
  final String error;

  const RankingBlocFailure(this.error);

  @override
  List<Object?> get props => [error];
}
