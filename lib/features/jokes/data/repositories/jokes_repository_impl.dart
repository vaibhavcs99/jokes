import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/jokes_entities.dart';
import '../../domain/repositories/jokes_repository.dart';
import '../data_sources/jokes_local_data_source.dart';
import '../data_sources/jokes_remote_data_source.dart';
import '../models/jokes_model.dart';

class JokesRepositoryImpl implements JokesRepository {
  final JokesRemoteDataSource remoteDataSource;
  final JokesLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  JokesRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, Jokes>> getGeneralJoke() async {
    if (await networkInfo.isConnected) {
      try {
        final JokesModel remoteGeneralJoke =
            await remoteDataSource.getGeneralJoke();

        localDataSource.cacheJoke(remoteGeneralJoke);

        return Right(remoteGeneralJoke);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localGeneralJoke = await localDataSource.getLastJoke();

        return Right(localGeneralJoke);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Jokes>> getProgrammingJoke() async {
    if (await networkInfo.isConnected) {
      try {
        final JokesModel remoteProgrammingJoke =
            await remoteDataSource.getProgrammingJoke();

        localDataSource.cacheJoke(remoteProgrammingJoke);

        return Right(remoteProgrammingJoke);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localProgrammingJoke = await localDataSource.getLastJoke();

        return Right(localProgrammingJoke);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
