import 'package:flutter/material.dart';
import 'package:flutter_application_1/presentacion/bloc/ranking_bloc.dart';
import 'package:flutter_application_1/presentacion/bloc/ranking_event.dart';
import 'package:flutter_application_1/presentacion/bloc/ranking_state.dart';
import 'package:flutter_application_1/presentacion/cubit/formulario_cubit.dart';
import 'package:flutter_application_1/presentacion/cubit/formulario_state.dart';
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
        appBar: AppBar(title: const Text('Demo Bloc/Cubit')),
        body: SafeArea(
          child: Column(
            children: [
              // ---------------- FORMULARIO (AUTH) ----------------
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocListener<FormularioCubit, FormularioState>(
                  listener: (context, state) {
                    if (state is FormularioCubitLoaded) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.mensaje)));
                    } else if (state is FormularioFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('❌ ${state.error}')),
                      );
                    }
                  },
                  child: const AuthFormCard(),
                ),
              ),

              const Divider(height: 0),

              // ---------------- USUARIOS ----------------
              Expanded(
                child: BlocBuilder<RankingBloc, RankingState>(
                  builder: (context, state) {
                    if (state is RankingBlocLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is RankingBlocLoaded) {
                      return ListView.builder(
                        itemCount: state.usuarios.length,
                        itemBuilder: (context, index) {
                          final usuario = state.usuarios[index];
                          return ListTile(
                            leading: const CircleAvatar(
                              child: Icon(Icons.person),
                            ),
                            title: Text(usuario.nombre),
                            subtitle: Text(usuario.correo),
                          );
                        },
                      );
                    } else if (state is RankingBlocFailure) {
                      return Center(child: Text("❌ ${state.error}"));
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthFormCard extends StatefulWidget {
  const AuthFormCard({super.key});

  @override
  State<AuthFormCard> createState() => _AuthFormCardState();
}

class _AuthFormCardState extends State<AuthFormCard> {
  final _formKey = GlobalKey<FormState>();
  final _correoCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void initState() {
    super.initState();

 
    // Disparamos login al iniciar
    Future.microtask(() {
      context.read<FormularioCubit>().enviarDatos(
        correo: _correoCtrl.text.trim(),
        contrasena: _passCtrl.text,
      );
    });
  }

  @override
  void dispose() {
    _correoCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<FormularioCubit>().state;
    final isLoading = state is FormularioCubitLoading;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: isLoading
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              )
            : Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 8),
                    const Text(
                      'Inicia sesión',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --------- CORREO ----------
                    TextFormField(
                      controller: _correoCtrl,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [
                        AutofillHints.username,
                        AutofillHints.email,
                      ],
                      decoration: const InputDecoration(
                        labelText: 'Correo',
                        hintText: 'tu@correo.com',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Ingresa tu correo';
                        }
                        final emailOk = RegExp(
                          r'^[^@]+@[^@]+\.[^@]+$',
                        ).hasMatch(v);
                        if (!emailOk) return 'Correo no válido';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // --------- CONTRASEÑA ----------
                    TextFormField(
                      controller: _passCtrl,
                      obscureText: _obscure,
                      autofillHints: const [AutofillHints.password],
                      decoration: InputDecoration(
                        labelText: 'Contraseña',
                        hintText: '••••••••',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscure = !_obscure),
                          icon: Icon(
                            _obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Ingresa tu contraseña';
                        }
                        if (v.length < 6) return 'Mínimo 6 caracteres';
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // --------- BOTÓN ENVIAR ----------
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<FormularioCubit>().enviarDatos(
                                    correo: _correoCtrl.text.trim(),
                                    contrasena: _passCtrl.text,
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Iniciar sesión'),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // --------- ACCIONES SECUNDARIAS ----------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: isLoading ? null : () {},
                          child: const Text('Olvidé mi contraseña'),
                        ),
                        TextButton(
                          onPressed: isLoading ? null : () {},
                          child: const Text('Crear cuenta'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
