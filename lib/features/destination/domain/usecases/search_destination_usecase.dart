import 'package:dartz/dartz.dart';
import 'package:travel_course/features/destination/domain/repositories/destination_repositories.dart';
import '../../../../core/error/failures.dart';
import '../entities/destination_entity.dart';

class SearchDestinationUseCase {
  final DestinationRepository _repository;

  SearchDestinationUseCase(this._repository);

  Future<Either<Failure, List<DestinationEntity>>> call() {
    return _repository.top();
  }
}
