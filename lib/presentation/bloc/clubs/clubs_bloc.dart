import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../../domain/use_case/get_all_club.dart';
import 'clubs_event.dart';
import 'clubs_state.dart';

class ClubsBloc extends Bloc<ClubsEvent, ClubsState> {
  final GetAllClubsUseCase getAllClubsUseCase;
  ClubsBloc({required this.getAllClubsUseCase}) : super(ClubsInitial()) {
    on<ClubsEvent>((event, emit) async {
      if (event is GetAllClubsEvent) {
        emit(LoadingClubState());
        final response = await getAllClubsUseCase();
        response.fold(
            (failure) => {emit(ErrorClubsState(message: failure.toString()))},
            (clubs) => {emit(SuccessClubsState(clubs: clubs))}
        );
      }
    });
  }
}
