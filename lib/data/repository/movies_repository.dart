import 'package:fusetek_movies/constants/constants.dart';
import 'package:fusetek_movies/data/api.dart';
import 'package:fusetek_movies/data/models/movies_model.dart';

class MoviesRepository {
  Future obtenerPeliculas({int? page}) async {
    Api api = Api();
    try {
      Map<String, String> params = {
        'api_key': apiKey,
        'language': lenguaje,
        'page': page.toString(),
      };
      final response = await api.get(
        '/3/movie/now_playing',
        params: params,
      );

      List<MoviesModel> lista = [];
      for (var item in response.data["results"]) {
        lista.add(MoviesModel.fromJson(item));
      }
      return lista;
    } catch (e) {}
  }
}
