import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Такое бывает'),
      ),
      body: Center(
        child: CachedNetworkImage(
          height: 300,
          width: 300,
          imageUrl:
              'https://skr.sh/s/250422/zJXaVrly.png?download=1&name=%D0%A1%D0%BA%D1%80%D0%B8%D0%BD%D1%88%D0%BE%D1%82%2011-01-2023%2018:24:23.png',
          progressIndicatorBuilder: (context, url, downloadProgress) => Container(
            margin: const EdgeInsets.all(100),
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
