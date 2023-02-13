import 'package:cleanutter/data/data_source/local_data_source.dart';
import 'package:cleanutter/data/data_source/remote_data_source.dart';
import 'package:cleanutter/domain/repository/club_repository.dart';
import 'package:cleanutter/util/failures.dart';
import 'package:dartz/dartz.dart';

import '../../domain/model/club.dart';
import '../../util/network_info.dart';
import '../model/club_dto.dart';

typedef Invoke = Future<Unit> Function();

class ClubRepositoryImpl extends ClubRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ClubRepositoryImpl(this.localDataSource, this.remoteDataSource,
      this.networkInfo);

  @override
  Future<Either<Failure, List<Club>>> getAllClubs() async {
    try {
      if (await networkInfo.isConnected) {
        final remoteClubs = await remoteDataSource.getAllClubs();
        localDataSource.saveClubs(remoteClubs);
        return Right(remoteClubs);
      } else {
        final localClubs = await localDataSource.getSavedClubs();
        return Right(localClubs);
      }
    } catch (e) {
      throw Left(Exception("Error occurred"));
    }
  }

  @override
  Future<Either<Failure, Unit>> addClub(Club club) async {
    final ClubDto clubDto = ClubDto(
        id: club.id,
        clubName: club.clubName,
        image: club.image,
        position: club.position,
        shortName: club.shortName,
        league: club.league);

    return await _getMessage(() {
      return remoteDataSource.addClub(clubDto);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteClub(String id) async {
    return await _getMessage(() {
      return remoteDataSource.deleteClub(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateClub(String id, Club club) async {
    final ClubDto clubDto = ClubDto(
        id: club.id,
        clubName: club.clubName,
        image: club.image,
        position: club.position,
        shortName: club.shortName,
    league: club.league);
    return await _getMessage(() => remoteDataSource.updateClub(id, clubDto));
  }

  Future<Either<Failure, Unit>> _getMessage(Invoke invoke) async {
    if (await networkInfo.isConnected) {
      try {
        await invoke();
        return const Right(unit);
      } catch (e) {
        print(e.toString());
        return Left(UnknownFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
