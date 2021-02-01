import 'package:flutter/material.dart';
import 'package:qr_mobile/theme/size_config.dart';

class AdminStock extends StatelessWidget {
  static String routeName = '/AdminStock';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stok',
            style: TextStyle(
              fontFamily: 'Kodchasan',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(right: getProportionateScreenWidth(100)),
                  child: Text(
                    'Ürün',
                    style: TextStyle(
                      fontFamily: 'Kodchasan',
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  'Miktar',
                  style: TextStyle(
                    fontFamily: 'Kodchasan',
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(108)),
                      child: Text(
                        'Kutu Kola',
                        style: TextStyle(
                          fontFamily: 'Kodchasan',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(90)),
                      child: Text(
                        '2',
                        style: TextStyle(
                          fontFamily: 'Kodchasan',
                        ),
                      ),
                    ),
                    Icon(
                      Icons.add,
                      color: Color(0xFF0E930B),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
