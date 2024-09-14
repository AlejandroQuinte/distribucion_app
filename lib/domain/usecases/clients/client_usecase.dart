import 'package:distribucion_app/core/error/result.dart';
import 'package:distribucion_app/data/repositories/db_local_repository.dart';
import 'package:distribucion_app/domain/entities/client.dart';

class ClientUseCase {
  final LocalDatabaseRepository repository;

  const ClientUseCase(this.repository);

  Future<Either<String, List<Client>>> deleteClientAndReturnUpdatedList(
    String id,
    List<Client> currentClients,
  ) async {
    try {
      int rowDeleted = await repository.deleteClient(id);

      if (rowDeleted == 0) {
        return Either.left("No se pudo eliminar el cliente.");
      }

      List<Client> updatedClients =
          currentClients.where((client) => client.idClient != id).toList();

      return Either.right(updatedClients);
    } catch (e) {
      return Either.left("Error: ${e.toString()}");
    }
  }

  Future<Either<String, List<Client>>> getAllClients() async {
    try {
      final clients = await repository.getAllClients();
      return Either.right(clients);
    } catch (e) {
      return Either.left("Error: ${e.toString()}");
    }
  }

  Future<Either<String, List<Client>>> addNewClientAndReturnUpdateList(
    Client newClient,
    List<Client> currentClients,
  ) async {
    try {
      final clientSaved = await repository.newClient(newClient);

      return Either.right(List.from(currentClients)..add(clientSaved));
    } catch (e) {
      return Either.left("Error: ${e.toString()}");
    }
  }
}
