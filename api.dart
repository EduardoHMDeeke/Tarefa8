import 'package:http/http.dart' as http;

const baseUrl = "https://api.tvmaze.com/search/shows?q=";

class API {
  static Future getMovie(search) async {
    var url = baseUrl + search;
    return await http.get(Uri.parse(url));
  }
}

class Movie {
  int id;
  String name;
  String link;
  String image;

  Movie(this.id, this.name, this.link, this.image);

  Movie.fromJson(Map json)
      : id = json['show']['id'],
        name = json['show']['name'],
        link = json['show']['url'],
        image = json['show']['image']['medium'];
}