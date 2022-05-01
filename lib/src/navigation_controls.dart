import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavigationControls extends StatelessWidget {
  const NavigationControls({required this.controller, Key? key})
      : super(key: key);

  final Completer<WebViewController> controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: controller.future,
      builder: (context, snapshot) {
        final WebViewController? controller = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done ||
            controller == null) {
          return Row(
            children: const <Widget>[
              Icon(Icons.home_filled),
              Icon(Icons.hiking_outlined),
              Icon(Icons.photo_album_outlined),
              Icon(Icons.create_outlined),
              Icon(Icons.account_circle_outlined),
              Icon(Icons.arrow_back_ios),
              Icon(Icons.arrow_forward_ios),
              Icon(Icons.replay),
            ],
          );
        }

        return Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home_filled),
              color: Colors.white,
              onPressed: () {
                controller.loadUrl('https://www.traveloftindia.com/');
              },
            ),
            IconButton(
              icon: const Icon(Icons.hiking_outlined),
              color: Colors.white,
              onPressed: () {
                controller
                    .loadUrl('https://www.traveloftindia.com/activities/');
              },
            ),
            IconButton(
              icon: const Icon(Icons.photo_album_outlined),
              color: Colors.white,
              onPressed: () {
                controller.loadUrl('https://www.traveloftindia.com/gallery/');
              },
            ),
            IconButton(
              icon: const Icon(Icons.create_outlined),
              color: Colors.white,
              onPressed: () {
                controller.loadUrl('https://www.hashstrix.com/tag/traveloft/');
              },
            ),
            IconButton(
              icon: const Icon(Icons.airplane_ticket_outlined),
              color: Colors.white,
              onPressed: () {
                controller.loadUrl(
                    'https://www.traveloftindia.com/booking/book-your-spot/');
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.white,
              onPressed: () async {
                if (await controller.canGoBack()) {
                  await controller.goBack();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No back history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              color: Colors.white,
              onPressed: () async {
                if (await controller.canGoForward()) {
                  await controller.goForward();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No forward history item')),
                  );
                  return;
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              color: Colors.white,
              onPressed: () {
                controller.reload();
              },
            ),
          ],
        );
      },
    );
  }
}
