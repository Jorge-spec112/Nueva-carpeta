import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentacion/bloc/ranking_bloc.dart';
import 'package:flutter_application_1/presentacion/bloc/ranking_event.dart';
import 'package:flutter_application_1/presentacion/bloc/ranking_state.dart';
import 'package:flutter_application_1/presentacion/cubit/jugadores_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialView extends StatelessWidget {
  const InitialView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FormularioCubit>(
          create: (context) => FormularioCubit()..loadData(),
        ),
        BlocProvider<RankingBloc>(
          create: (context) => RankingBloc()..add(LoadBlocEvent()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text('data')),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<RankingBloc, RankingState>(
                builder: (context, state) {
                  if (state is RankingBlocLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is RankingBlocLoaded) {
                    if (state.jugadores.isEmpty) {
                      return const Center(child: Text("No hay jugadores"));
                    }
                    return ListView.builder(
                      itemCount: state.jugadores.length,
                      itemBuilder: (context, index) {
                        final jugador = state.jugadores[index];
                        return ListTile(
                          leading: CircleAvatar(child: Text(jugador.nombre[0])),
                          title: Text(jugador.nombre),
                          subtitle: Text("Puntaje: ${jugador.puntaje}"),
                        );
                      },
                    );
                  }
                  return Center(
                    child: ElevatedButton(
                      onPressed: () =>
                          context.read<RankingBloc>().add(LoadBlocEvent()),
                      child: const Text('Cargar ranking'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
