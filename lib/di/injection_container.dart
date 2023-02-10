import 'package:cleanutter/data/data_source/local_data_source.dart';
import 'package:cleanutter/data/data_source/remote_data_source.dart';
import 'package:cleanutter/data/repository/club_repository_impl.dart';
import 'package:cleanutter/domain/repository/club_repository.dart';
import 'package:cleanutter/domain/use_case/add_club.dart';
import 'package:cleanutter/domain/use_case/delete_club.dart';
import 'package:cleanutter/domain/use_case/get_all_club.dart';
import 'package:cleanutter/domain/use_case/update_club.dart';
import 'package:cleanutter/presentation/bloc/clubs/clubs_bloc.dart';
import 'package:cleanutter/presentation/bloc/detail/detail_bloc.dart';
import 'package:cleanutter/util/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => ClubsBloc(getAllClubsUseCase: sl()));
  sl.registerFactory(() => DetailBloc(addClubUseCase: sl(), updateClubUseCase: sl(), deleteClubUseCase: sl()));

  sl.registerLazySingleton(() => GetAllClubsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateClubUseCase(sl()));
  sl.registerLazySingleton(() => DeleteClubUseCase(sl()));
  sl.registerLazySingleton(() => AddClubUseCase(sl()));

  sl.registerLazySingleton<ClubRepository>(
      () => ClubRepositoryImpl(sl(), sl(), sl()));

  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  final shared = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => shared);

  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
