import 'package:equatable/equatable.dart';

import '../../../domain/model/club.dart';

abstract class ClubsState extends Equatable {
  const ClubsState();

  @override
  List<Object?> get props => [];
}

class ClubsInitial extends ClubsState {}

class LoadingClubState extends ClubsState {}

class SuccessClubsState extends ClubsState {
  final List<Club> clubs;

  const SuccessClubsState({required this.clubs});

  @override
  List<Object?> get props => [clubs];
}

class ErrorClubsState extends ClubsState {
  final String message;

  const ErrorClubsState({required this.message});

  @override
  List<Object?> get props => [message];
}
