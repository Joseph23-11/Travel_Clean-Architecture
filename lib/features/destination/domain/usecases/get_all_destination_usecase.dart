import 'package:dartz/dartz.dart';
import 'package:travel_course/core/error/failures.dart';
import 'package:travel_course/features/destination/domain/entities/destination_entity.dart';
import 'package:travel_course/features/destination/domain/repositories/destination_repositories.dart';

class GetAllDestinationUseCase {
  final DestinationRepository _repository;

  GetAllDestinationUseCase(this._repository);

  Future<Either<Failure, List<DestinationEntity>>> call() {
    return _repository.all();
  }
}
