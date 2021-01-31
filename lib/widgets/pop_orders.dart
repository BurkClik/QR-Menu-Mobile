import 'package:flutter/material.dart';
import 'package:qr_mobile/theme/size_config.dart';

class PopOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0, bottom: 16.0),
      child: Container(
        child: Column(
          children: [
            Image.network(
              "https://source.unsplash.com/random",
              height: 120,
              width: 376,
              fit: BoxFit.cover,
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: Color(0xFFFC8B8E)),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.25),
            )
          ],
        ),
      ),
    );
  }
}
