import 'package:equatable/equatable.dart';

abstract class FormularioState extends Equatable {
  const FormularioState();

  @override
  List<Object?> get props => [];
}

class FormularioInitial extends FormularioState {}

class FormularioCubitLoading extends FormularioState {}

class FormularioCubitLoaded extends FormularioState {
  final String mensaje;

  const FormularioCubitLoaded({required this.mensaje});

  @override
  List<Object?> get props => [mensaje];
}

class FormularioFailure extends FormularioState {
  final String error;

  const FormularioFailure(this.error);

  @override
  List<Object?> get props => [error];
}
