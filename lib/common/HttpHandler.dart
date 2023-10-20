import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieapp_200561/common/Constants.dart';
import 'package:movieapp_200561/model/Media.dart';

class HttpHandler {
  static final _httHandler = new HttpHandler();
  final String _baseUrl = "api.themoviedb.org"; // Define la URL base de la API.
  final String _language =
      "en-US"; // Define el lenguaje deseado para las respuestas.

  static HttpHandler get() {
    return _httHandler;
  }

  // Define una función asincrónica para obtener datos JSON desde una URI.
  Future<dynamic> getJson(Uri uri) async {
    http.Response response =
        await http.get(uri); // Realiza una solicitud GET HTTP.
    return json.decode(response.body); // Decodifica la respuesta JSON.
  }

  // Define una función para recuperar una lista de películas.
  Future<List<Media>> fetchMovies({String category = "populares"}) async {
    var uri = new Uri.https(_baseUrl, "3/movie/$category", // Crea una URI para obtener películas populares.
        {
          'api_key': API_KEY,
          'page': "1",
          'language': _language
        }); // Parámetros de la solicitud.
    // Llama a la función getJson para obtener datos y mapearlos en objetos de tipo Media.
    return getJson(uri).then(((data) => data['results']
        .map<Media>((item) => new Media(item, MediaType.movie))
        .toList()));
  }

  Future<List<Media>> fetchShow({String category = "populares"})  async {
    var uri = new Uri.https(_baseUrl, "3/tv/$category", {
      'api_key': API_KEY,
      'page': "1",
      'language': _language
    }); // Parámetros de la solicitud.
    // Llama a la función getJson para obtener datos y mapearlos en objetos de tipo Media.
    return getJson(uri).then(((data) => data['results']
        .map<Media>((item) => new Media(item, MediaType.show))
        .toList()));
  }
}
