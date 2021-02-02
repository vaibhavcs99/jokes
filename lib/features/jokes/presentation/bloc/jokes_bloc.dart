import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/jokes_entities.dart';
import '../../domain/usecases/get_general_jokes.dart';
import '../../domain/usecases/get_programming_jokes.dart';

part 'jokes_event.dart';
part 'jokes_state.dart';

class JokesBloc extends Bloc<JokesEvent, JokesState> {
  final GetGeneralJokes getGeneralJokes;
  final GetProgrammingJokes getProgrammingJokes;

  JokesBloc({
    @required this.getGeneralJokes,
    @required this.getProgrammingJokes,
  }) : super(JokesInitial());

  @override
  Stream<JokesState> mapEventToState(
    JokesEvent event,
  ) async* {
    if (event is OnGeneralJokePressed) {
      yield JokesLoading();

      Either<Failure, Jokes> jokesOrFailure = await getGeneralJokes.call();

      yield* jokesOrFailure.fold((failure) async* {
        yield JokesUnsuccessful(errorMessage: failure.toString());
      }, (jokes) async* {
        yield JokesSuccessful(jokes: jokes);
      });
    }

    if (event is OnProgrammingJokePressed) {
      yield JokesLoading();

      Either<Failure, Jokes> jokesOrFailure = await getProgrammingJokes.call();

      yield* jokesOrFailure.fold((failure) async* {
        yield JokesUnsuccessful(errorMessage: failure.toString());
      }, (jokes) async* {
        yield JokesSuccessful(jokes: jokes);
      });
    }
  }
}
