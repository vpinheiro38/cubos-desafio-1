import 'dart:developer';

import 'package:cubos_desafio_1/movie.dart';
import 'package:cubos_desafio_1/movies_controller.dart';
import 'package:flutter/material.dart';

class MoviesView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MoviesViewState();
}

class _MoviesViewState extends State<MoviesView> {
  final controller = MoviesController();

  @override
  void initState() {
    controller.loadMovies();
    super.initState();
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.red,
        toolbarHeight: 80,
        title: Container(
          alignment: Alignment.center,
          child: TextLabel('Lançamentos', 20),
        )
    );
  }
  
  _buildBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red,
            Colors.black,
          ],
        )
      ),
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder<List<Movie>>(
                future: controller.movies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done)
                    return Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    );

                  if (snapshot.hasData) {
                    return _buildMoviesList(snapshot.data);
                  } else if (snapshot.hasError) {
                    return Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: TextWithStyle('Não foi possível encontrar filmes', 20),
                          ),
                          ElevatedButton(
                              child: TextWithStyle('Tentar Novamente', 16),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.red)
                              ),
                              onPressed: () {
                                setState(() {
                                  controller.loadMovies();
                                });
                              })
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              )
          )
        ],
      ),
    );
  }

  _buildMoviesList(List<Movie> movies) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardMargin = (screenWidth - 300)/2;

    return ListView.builder(
        itemCount: movies.length,
        padding: const EdgeInsets.only(top: 40),
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(left: cardMargin, right: cardMargin, bottom: 40),
            height: 440,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(movies[index].posterUrl),
                  fit: BoxFit.fill
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(2, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.all(20),
                  child: TextLabel(movies[index].releasedDate, 16, horizontalPadding: 20,),
                ),
                Expanded(child: Container(),),
                Container(
                  color: Colors.black.withOpacity(0.5),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(20),
                  child: TextWithStyle(movies[index].title, 16),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context)
    );
  }
}

class TextLabel extends StatelessWidget {
  final String _text;
  final double _fontSize;
  final double horizontalPadding;

  TextLabel(this._text, this._fontSize, {this.horizontalPadding = 50});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 8, horizontalPadding, 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.black.withOpacity(0.8)
      ),
      child: TextWithStyle(_text, _fontSize),
    );
  }
}

class TextWithStyle extends StatelessWidget {
  final String _text;
  final double _fontSize;

  TextWithStyle(this._text, this._fontSize);

  @override
  Widget build(BuildContext context) {
    return Text(_text, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: _fontSize));
  }
}