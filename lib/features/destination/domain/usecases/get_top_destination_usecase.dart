import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/destination_entity.dart';
import '../repositories/destination_repositories.dart';

class GetTopDestinationUseCase {
  final DestinationRepository _repository;

  GetTopDestinationUseCase(this._repository);

  Future<Either<Failure, List<DestinationEntity>>> call() {
    return _repository.top();
  }
}
