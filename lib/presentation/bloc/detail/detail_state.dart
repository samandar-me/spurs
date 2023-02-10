import 'package:equatable/equatable.dart';

abstract class DetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailInitial extends DetailState {}

class LoadingDetailState extends DetailState {}

class MessageDetailState extends DetailState {
  final String message;

  MessageDetailState(this.message);

  @override
  List<Object?> get props => [message];
}

class ErrorDetailState extends DetailState {
  final String message;

  ErrorDetailState({required this.message});

  @override
  List<Object?> get props => [message];
}