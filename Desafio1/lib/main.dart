import 'package:flutter/material.dart';
import 'movie.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  build(context) {
    return const MaterialApp(
      title: 'Filmes',
      home: MoviesListView(),
    );
  }
}
