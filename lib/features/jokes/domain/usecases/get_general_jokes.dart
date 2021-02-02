import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/failures.dart';
import '../entities/jokes_entities.dart';
import '../repositories/jokes_repository.dart';

class GetGeneralJokes {
  final JokesRepository jokesRepository;

  GetGeneralJokes({
    @required this.jokesRepository,
  });

  Future<Either<Failure, Jokes>> call()async {
    return  await jokesRepository.getGeneralJoke();
  }
}
