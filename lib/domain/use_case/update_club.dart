import 'package:cleanutter/domain/model/club.dart';
import 'package:cleanutter/domain/repository/club_repository.dart';
import 'package:cleanutter/util/failures.dart';
import 'package:dartz/dartz.dart';

class UpdateClubUseCase {
  final ClubRepository repository;

  UpdateClubUseCase(this.repository);

  Future<Either<Failure,Unit>> call(String id, Club club) async {
    return await repository.updateClub(id, club);
  }
}