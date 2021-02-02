import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/jokes_model.dart';

abstract class JokesRemoteDataSource {
  Future<JokesModel> getGeneralJoke();
  Future<JokesModel> getProgrammingJoke();
}

class JokesRemoteDataSourceImpl implements JokesRemoteDataSource {
  final Dio dio;
  JokesRemoteDataSourceImpl({
    @required this.dio,
  });

  @override
  Future<JokesModel> getGeneralJoke() async {
    final Response response = await dio.get(jokesGeneralApiPath);

    if (response.statusCode == 200) {
      final jokesModel = JokesModel.fromJson(response.data[0]);
      return jokesModel;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<JokesModel> getProgrammingJoke() async {
    final Response response = await dio.get(jokesProgrammingApiPath);

    if (response.statusCode == 200) {
      final jokesModel = JokesModel.fromJson(response.data[0]);
      return jokesModel;
    } else {
      throw ServerException();
    }
  }
}
