import 'package:distribucion_app/data/repositories/db_local_repository.dart';
import 'package:distribucion_app/domain/entities/distribution.dart';

class GetAllDistributionsByDateUseCase {
  final LocalDatabaseRepository repository;

  GetAllDistributionsByDateUseCase(this.repository);

  Future<List<Distribution>> execute(DateTime date) async {
    return await repository.getAllDistributionByDate(date);
  }
}
