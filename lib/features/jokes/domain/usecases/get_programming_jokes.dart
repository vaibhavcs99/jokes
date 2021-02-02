import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/failures.dart';
import '../entities/jokes_entities.dart';
import '../repositories/jokes_repository.dart';

class GetProgrammingJokes {
  final JokesRepository jokesRepository;

  GetProgrammingJokes({
    @required this.jokesRepository,
  });

  Future<Either<Failure, Jokes>> call()async {
    return  await jokesRepository.getProgrammingJoke();
  }
}
