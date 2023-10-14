import 'package:flutter/material.dart';
import 'package:kimit_workshop/models/news_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  NewsDetailsScreen({super.key, required this.item});
  Articles item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.author!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: item.urlToImage!,
              child: Image.network(
                item.urlToImage!,
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * .5,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(item.publishedAt!),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(item.title!),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(item.description!),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(item.content!),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  final _url = Uri.parse(item.url!);
                  if (!await launchUrl(_url)) {
                    throw Exception('Could not launch $_url');
                  }
                },
                child: const Text("Want To Read More Click Here"))
          ],
        ),
      ),
    );
  }
}
