part of 'jokes_bloc.dart';

abstract class JokesState extends Equatable {
  const JokesState();

  @override
  List<Object> get props => [];
}

class JokesInitial extends JokesState {}

class JokesLoading extends JokesState {}

class JokesSuccessful extends JokesState {
  final Jokes jokes;
  JokesSuccessful({
    @required this.jokes,
  });
}

class JokesUnsuccessful extends JokesState {
  final String errorMessage;
  JokesUnsuccessful({
    @required this.errorMessage,
  });
}
