abstract class FormularioState {}

class FormularioInitial extends FormularioState {}

class FormularioCubitLoading extends FormularioState {}

class FormularioCubitLoaded extends FormularioState {
  final String data;
  FormularioCubitLoaded(this.data);
}
