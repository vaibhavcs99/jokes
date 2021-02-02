import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/jokes_entities.dart';

abstract class JokesRepository {
  Future<Either<Failure,Jokes>> getGeneralJoke();
  Future<Either<Failure,Jokes>> getProgrammingJoke();
}
