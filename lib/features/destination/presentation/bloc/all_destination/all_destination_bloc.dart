import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_course/features/destination/domain/entities/destination_entity.dart';
import 'package:travel_course/features/destination/domain/usecases/get_top_destination_usecase.dart';

part 'all_destination_event.dart';
part 'all_destination_state.dart';

class AllDestinationBloc
    extends Bloc<AllDestinationEvent, AllDestinationState> {
  final GetTopDestinationUseCase useCase;

  AllDestinationBloc(this.useCase) : super(AllDestinationInitial()) {
    on<OnGetAllDestination>((event, emit) async {
      emit(AllDestinationLoading());
      final result = await useCase();
      result.fold(
        (failure) => emit(AllDestinationFailure(failure.message)),
        (data) => emit(AllDestinationLoaded(data)),
      );
    });
  }
}
