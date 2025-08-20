import 'package:equatable/equatable.dart';

abstract class RankingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadBlocEvent extends RankingEvent {}
