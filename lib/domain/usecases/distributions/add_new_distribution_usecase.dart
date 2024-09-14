import 'package:distribucion_app/data/repositories/db_local_repository.dart';
import 'package:distribucion_app/domain/entities/distribution.dart';

class AddNewDistributionUseCase {
  final LocalDatabaseRepository repository;

  AddNewDistributionUseCase(this.repository);

  Future<int> execute(List<Distribution> distributions) async {
    if (distributions.isEmpty) {
      throw ArgumentError('No distributions provided');
    }
    return await repository.addNewDistribution(distributions);
  }
}
