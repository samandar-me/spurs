
import 'package:cleanutter/domain/model/club.dart';
import 'package:cleanutter/domain/repository/club_repository.dart';
import 'package:cleanutter/util/failures.dart';
import 'package:dartz/dartz.dart';

class AddClubUseCase {
  final ClubRepository repository;

  AddClubUseCase(this.repository);

  Future<Either<Failure, Unit>> call(Club club) async {
    return await repository.addClub(club);
  }
}