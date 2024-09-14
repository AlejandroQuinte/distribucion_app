import 'package:distribucion_app/domain/entities/client.dart';
import 'package:distribucion_app/presentation/blocs/blocs.dart';
import 'package:distribucion_app/data/repositories/db_local_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientList extends StatelessWidget {
  const ClientList({super.key});

  @override
  Widget build(BuildContext context) {
    final cBloc = context.read<ClientBloc>();

    final size = MediaQuery.of(context).size;

    return BlocBuilder<ClientBloc, ClientState>(builder: (context, state) {
      final clients = state.clients;
      return SizedBox(
        height: size.height * 0.6,
        child: Column(
          children: [
            const Text('Clientes', style: TextStyle(fontSize: 25)),
            Expanded(
              child: ListView.builder(
                itemCount: clients.length,
                itemBuilder: (context, index) {
                  final client = clients[index];
                  return ListTile(
                    title: Text('Nombre: ${client.name}'),
                    subtitle: Text('Codigo: ${client.code.toString()}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        cBloc.add(
                          DeleteOneClient(
                            idClient: client.idClient.toString(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
