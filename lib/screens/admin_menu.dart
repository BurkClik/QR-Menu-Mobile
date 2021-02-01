import 'package:flutter/material.dart';
import 'package:qr_mobile/screens/admin_add_item.dart';
import 'package:qr_mobile/theme/size_config.dart';

class AdminMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Menü',
                style: TextStyle(
                  fontFamily: 'Kodchasan',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminAddItem()));
                },
                child: Text('Ürün Ekle'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFFFC8B8E),
                  onPrimary: Colors.black,
                  textStyle: TextStyle(
                    fontFamily: 'Kodchasan',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              )
            ],
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
                  'Kategori',
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
                          right: getProportionateScreenWidth(92)),
                      child: Text(
                        'Kutu Kola',
                        style: TextStyle(
                          fontFamily: 'Kodchasan',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(72)),
                      child: Text(
                        'Meşrubat',
                        style: TextStyle(
                          fontFamily: 'Kodchasan',
                        ),
                      ),
                    ),
                    Icon(
                      Icons.settings,
                      color: Color(0xFFFC8B8E),
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
