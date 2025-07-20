import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/blinking_touch.dart';
import 'package:flutter_application_1/pages/item_list.dart';

class ThumbnailTouchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ItemList()),
          );
        },
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'lib/assets/images/thumbnail_rec.png',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              bottom: 50,
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
