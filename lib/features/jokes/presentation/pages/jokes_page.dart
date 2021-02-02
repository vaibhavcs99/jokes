import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/jokes_bloc.dart';

class JokesPage extends StatefulWidget {
  @override
  _JokesPageState createState() => _JokesPageState();
}

class _JokesPageState extends State<JokesPage> {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
        appBar: AppBar(title: Text('Home Page')),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<JokesBloc, JokesState>(
                builder: (context, state) {
                  if (state is JokesSuccessful) {
                    return Column(
                      children: [
                        Text(state.jokes.type),
                        Text(state.jokes.setup),
                        Text(state.jokes.punchline),
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: RaisedButton(
                      onPressed: () => BlocProvider.of<JokesBloc>(context)
                          .add(OnGeneralJokePressed()),
                      child: Text('General Joke'),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () => BlocProvider.of<JokesBloc>(context)
                          .add(OnProgrammingJokePressed()),
                      child: Text('Programming Joke'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
