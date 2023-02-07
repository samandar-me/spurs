import 'package:cleanutter/domain/repository/club_repository.dart';
import 'package:cleanutter/util/failures.dart';
import 'package:dartz/dartz.dart';

class DeleteClubUseCase {
  final ClubRepository repository;

  DeleteClubUseCase(this.repository);

  Future<Either<Failure, Unit>> call(String id) async {
    return await repository.deleteClub(id);
  }
}