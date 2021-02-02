import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import '../../../../core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/jokes_model.dart';
import '../../domain/entities/jokes_entities.dart';

abstract class JokesLocalDataSource {
  Future<Jokes> getLastJoke();

  Future<void> cacheJoke(JokesModel jokesModel);
}

class JokesLocalDataSourceImpl implements JokesLocalDataSource {
  final SharedPreferences sharedPreferences;
  JokesLocalDataSourceImpl({
    @required this.sharedPreferences,
  });
  @override
  // ignore: missing_return
  Future<void> cacheJoke(JokesModel jokes) {
    sharedPreferences.setString(cached_joke, jsonEncode(jokes.toJson()));
  }

  @override
  Future<JokesModel> getLastJoke() {
    final jokesString = sharedPreferences.getString(cached_joke);
    final jokesJson = jsonDecode(jokesString);
    final jokesModel = JokesModel.fromJson(jokesJson);

    return Future.value(jokesModel);
  }
}
