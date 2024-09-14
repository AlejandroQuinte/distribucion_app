part of 'client_bloc.dart';

@immutable
sealed class ClientEvent {}

final class GetClients extends ClientEvent {
  final List<Client> clients;
  GetClients({required this.clients});
}

final class AddOneClient extends ClientEvent {
  final Client client;
  AddOneClient({required this.client});
}

final class DeleteOneClient extends ClientEvent {
  final String idClient;
  DeleteOneClient({required this.idClient});
}
