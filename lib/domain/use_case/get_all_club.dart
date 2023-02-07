
import 'package:cleanutter/domain/model/club.dart';
import 'package:cleanutter/domain/repository/club_repository.dart';
import 'package:cleanutter/util/failures.dart';
import 'package:dartz/dartz.dart';

class GetAllClubsUseCase {
  final ClubRepository repository;

  GetAllClubsUseCase(this.repository);

  Future<Either<Failure, List<Club>>> call() async {
    return await repository.getAllClubs();
  }
}