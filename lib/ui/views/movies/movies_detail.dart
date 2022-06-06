import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fusetek_movies/data/models/movies_model.dart';
import 'package:fusetek_movies/ui/views/movies/widgets/image.dart';
import 'package:fusetek_movies/ui/widgets/text_widgets.dart';
import 'package:fusetek_movies/utils/utils.dart';

class MovieDetail extends StatefulWidget {
  MovieDetail({Key? key, this.movie});
  MoviesModel? movie;

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      backgroundColor: Colors.black,
      body: widget.movie!.title == null || widget.movie!.backdrop == null
          ? Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    normalText('No hay informacion'),
                    const SizedBox(height: 20),
                    TextButton(
                      child: Container(
                        width: 200,
                        child: const Center(
                          child: Text(
                            'Regresar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.amber,
                        onSurface: Colors.yellow,
                        side: const BorderSide(color: Colors.black, width: 2),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      imageHeader(widget.movie!.backdrop),
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 0),
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(
                                  Icons.chevron_left,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                  infoMovie(),
                ],
              ),
            ),
    );
  }

  Widget infoMovie() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleText(widget.movie!.title!),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.movie!.vote!.toString(),
                style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              RatingBar.builder(
                initialRating: (widget.movie!.vote!.toInt() / 2),
                minRating: 1,
                itemSize: 18,
                unratedColor: Colors.white,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          normalText(widget.movie!.overview!),
          const SizedBox(height: 20),
          Text(
            'Fecha de lanzamiento: ' + formattDate(widget.movie!.releaseDate),
            style: TextStyle(color: Colors.grey[400]),
          ),
          widget.movie!.adult! == false
              ? const Chip(
                  label: Text('Para todos'),
                )
              : const Chip(
                  label: Text('Solo adultos'),
                )
        ],
      ),
    );
  }
}
