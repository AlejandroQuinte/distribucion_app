import 'package:distribucion_app/data/repositories/db_local_repository.dart';
import 'package:distribucion_app/domain/entities/distribution.dart';

class UpdateDistributionUseCase {
  final LocalDatabaseRepository repository;

  const UpdateDistributionUseCase(this.repository);

  Future<int> execute(List<Distribution> data) async {
    return await repository.updateDistribution(data);
  }
}
