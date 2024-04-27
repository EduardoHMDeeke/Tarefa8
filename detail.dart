import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'api.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;
  
  const DetailPage(this.movie, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Center(
              child: Image(
                image: NetworkImage(
                  movie.image,
                ),
              ),
            ),
            const Text("Link:"),
            Linkify(
              onOpen: (link) async {
                Uri link = Uri.parse(movie.link);
                if (await canLaunchUrl(link)) {
                  await launchUrl(link);
                } else {
                  throw 'Não foi possivel abrir ${movie.link}';
                }
              },
              text: movie.link,
            ),
          ],
        ),
      ),
    );
  }
}