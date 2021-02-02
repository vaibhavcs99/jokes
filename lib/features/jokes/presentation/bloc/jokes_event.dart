part of 'jokes_bloc.dart';

abstract class JokesEvent extends Equatable {
  const JokesEvent();

  @override
  List<Object> get props => [];
}

class OnGeneralJokePressed extends JokesEvent{}

class OnProgrammingJokePressed extends JokesEvent{}
