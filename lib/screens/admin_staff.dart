import 'package:flutter/material.dart';
import 'package:qr_mobile/screens/admin_add_staff.dart';
import 'package:qr_mobile/theme/size_config.dart';

class AdminStaff extends StatelessWidget {
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
                'Çalışanlar',
                style: TextStyle(
                  fontFamily: 'Kodchasan',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminAddStaff(),
                    ),
                  );
                },
                child: Text('Çalışan Ekle'),
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
                    'İsim',
                    style: TextStyle(
                      fontFamily: 'Kodchasan',
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  'Telefon',
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
                          right: getProportionateScreenWidth(68)),
                      child: Text(
                        'Civan Gür',
                        style: TextStyle(
                          fontFamily: 'Kodchasan',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: getProportionateScreenWidth(52)),
                      child: Text(
                        '507 777 99 56',
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
