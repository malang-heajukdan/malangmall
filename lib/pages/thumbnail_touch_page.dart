import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/blinking_touch.dart';
import 'package:flutter_application_1/pages/item_list.dart';

class ThumbnailTouchPage extends StatelessWidget {
  final String imagePath;
  const ThumbnailTouchPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ItemList()),
          );
        },
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            const Positioned(
              bottom: 70,
              left: 0,
              right: 0,
              child: Center(child: BlinkingTouch(text: 'Touch!')),
            ),
          ],
        ),
      ),
    );
  }
}
