import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/network_info.dart';
import 'features/jokes/data/data_sources/jokes_local_data_source.dart';
import 'features/jokes/data/data_sources/jokes_remote_data_source.dart';
import 'features/jokes/data/repositories/jokes_repository_impl.dart';
import 'features/jokes/domain/repositories/jokes_repository.dart';
import 'features/jokes/domain/usecases/get_general_jokes.dart';
import 'features/jokes/domain/usecases/get_programming_jokes.dart';
import 'features/jokes/presentation/bloc/jokes_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Jokes

  //blocs

  sl.registerFactory(
    () => JokesBloc(
      getGeneralJokes: sl(),
      getProgrammingJokes: sl(),
    ),
  );

  //Use Cases

  sl.registerLazySingleton(() => GetGeneralJokes(jokesRepository: sl()));
  sl.registerLazySingleton(() => GetProgrammingJokes(jokesRepository: sl()));

  //Repository

  sl.registerLazySingleton<JokesRepository>(() => JokesRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  //DataSources

  sl.registerLazySingleton<JokesRemoteDataSource>(
      () => JokesRemoteDataSourceImpl(dio: sl()));
  sl.registerLazySingleton<JokesLocalDataSource>(
      () => JokesLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(dataConnectionChecker: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
