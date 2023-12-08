import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_course/features/destination/domain/entities/destination_entity.dart';

import '../../../domain/usecases/get_top_destination_usecase.dart';

part 'top_destination_event.dart';
part 'top_destination_state.dart';

class TopDestinationBloc
    extends Bloc<TopDestinationEvent, TopDestinationState> {
  final GetTopDestinationUseCase useCase;

  TopDestinationBloc(this.useCase) : super(TopDestinationInitial()) {
    on<OnGetTopDestination>((event, emit) async {
      emit(TopDestinationLoading());
      final result = await useCase();
      result.fold(
        (failure) => emit(TopDestinationFailure(failure.message)),
        (data) => emit(TopDestinationLoaded(data)),
      );
    });
  }
}
