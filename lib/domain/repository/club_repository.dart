import 'package:dartz/dartz.dart';
import '../../util/failures.dart';
import '../model/club.dart';

abstract class ClubRepository {
  Future<Either<Failure,List<Club>>> getAllClubs();
  Future<Either<Failure,Unit>> deleteClub(String id);
  Future<Either<Failure,Unit>> updateClub(String id, Club club);
  Future<Either<Failure,Unit>> addClub(Club club);
}