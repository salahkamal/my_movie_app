import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mymovieapp/provider/movie_provider.dart';
import 'package:provider/provider.dart';
import 'ui/MovieListScreen.dart';

void main() {
  // Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primaryColor: Colors.amber,
      ),
      home: ChangeNotifierProvider<MovieProvider>(
        create: (context) => MovieProvider(),
        child: MovieListScreen(),
      ),
    );
  }
}
