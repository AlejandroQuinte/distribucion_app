part of 'client_bloc.dart';

@immutable
class ClientState {
  final List<Client> clients;

  const ClientState({required this.clients});

  ClientState copyWith({
    List<Client>? clients,
  }) {
    return ClientState(
      clients: clients ?? this.clients,
    );
  }
}

final class ClientInitial extends ClientState {
  ClientInitial() : super(clients: []);
}
