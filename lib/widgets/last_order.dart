import 'package:flutter/material.dart';
import 'package:qr_mobile/theme/size_config.dart';

class LastOrder extends StatelessWidget {
  final String url;
  final int price;
  final String productName;
  final String status;

  LastOrder({this.url, this.price, this.productName, this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(url),
              radius: 36.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontFamily: 'Kodchasan',
                      fontWeight: FontWeight.w900,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(28)),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            fontFamily: 'Kodchasan',
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFD9F5F8),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "$price₺",
              style: TextStyle(
                fontFamily: 'Kodchasan',
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0E930B),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: Color(0xFFFC8B8E)),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.25),
              )
            ]),
      ),
    );
  }
}
