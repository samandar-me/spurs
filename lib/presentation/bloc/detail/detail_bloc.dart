import 'package:bloc/bloc.dart';

import '../../../domain/use_case/add_club.dart';
import '../../../domain/use_case/delete_club.dart';
import '../../../domain/use_case/update_club.dart';
import 'detail_event.dart';
import 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final AddClubUseCase addClubUseCase;
  final DeleteClubUseCase deleteClubUseCase;
  final UpdateClubUseCase updateClubUseCase;

  DetailBloc(
      {required this.addClubUseCase,
      required this.updateClubUseCase,
      required this.deleteClubUseCase})
      : super(DetailInitial()) {
    on<DetailEvent>((event, emit) async {
      if (event is AddClubEvent) {
        emit(LoadingDetailState());
        final message = await addClubUseCase(event.club);
        message.fold((l) => {emit(ErrorDetailState(message: l.toString()))},
            (r) => {emit(MessageDetailState("Club created successfully"))});
      } else if (event is UpdateClubEvent) {
        emit(LoadingDetailState());
        final message = await updateClubUseCase(event.id, event.club);
        message.fold((l) => {emit(ErrorDetailState(message: l.toString()))},
            (r) => {emit(MessageDetailState("Club updated successfully"))});
      } else if (event is DeleteClubEvent) {
        emit(LoadingDetailState());
        final message = await deleteClubUseCase(event.id);
        message.fold((l) => {emit(ErrorDetailState(message: l.toString()))},
            (r) => {emit(MessageDetailState("Club deleted successfully"))});
      }
    });
  }
}
