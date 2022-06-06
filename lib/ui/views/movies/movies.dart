// ignore_for_file: unnecessary_new, avoid_unnecessary_containers

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fusetek_movies/constants/constants.dart';
import 'package:fusetek_movies/data/models/movies_model.dart';
import 'package:fusetek_movies/data/repository/movies_repository.dart';
import 'package:fusetek_movies/services/auth.dart';
import 'package:fusetek_movies/ui/views/movies/movies_detail.dart';
import 'package:fusetek_movies/ui/widgets/text_widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class Movies extends StatefulWidget {
  Movies({Key? key});

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  List<MoviesModel> moviesList = [];
  final ScrollController scrollController = ScrollController();
  int page = 1;
  @override
  void initState() {
    super.initState();
    loadMovies();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;
        loadMovies();
      }
    });
  }

  loadMovies() async {
    MoviesRepository moviesRepository = new MoviesRepository();
    final response = await moviesRepository.obtenerPeliculas(page: page);
    setState(() {
      moviesList.addAll(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            children: [
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: titleText('Peliculas principales'),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleText('Peliculas principales'),
                  IconButton(
                    onPressed: () async {
                      await auth.logout();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Flexible(
                child: ListView.builder(
                    // ignore: prefer_if_null_operators
                    controller: scrollController,
                    itemCount: moviesList.length,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => new MovieDetail(
                                movie: moviesList[i],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: imagePath + moviesList[i].image!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 200,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                height: 200,
                                width: 100,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    moviesList[i].title!,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                    overflow: TextOverflow.clip,
                                  ),
                                  Container(
                                    // width: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          moviesList[i].vote!.toString(),
                                          style: const TextStyle(
                                            color: Colors.amber,
                                          ),
                                        ),
                                        RatingBar.builder(
                                          initialRating:
                                              (moviesList[i].vote!.toInt() / 2),
                                          minRating: 1,
                                          itemSize: 18,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          unratedColor: Colors.white,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    moviesList[i]
                                            .voteCount!
                                            .toInt()
                                            .toString() +
                                        ' Votantes',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
