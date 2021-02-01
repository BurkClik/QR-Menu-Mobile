import 'package:flutter/material.dart';

class AdminOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Siparişler',
            style: TextStyle(
              fontFamily: 'Kodchasan',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xFFFC8B8E),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.25),
                          )
                        ]),
                    child: ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Civan Gür',
                            style: TextStyle(
                              fontFamily: 'Kodchasan',
                            ),
                          ),
                          Text(
                            '1101-00001',
                            style: TextStyle(
                              fontFamily: 'Kodchasan',
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Beklemede',
                              style: TextStyle(
                                fontFamily: 'Kodchasan',
                                fontWeight: FontWeight.w800,
                                fontSize: 16.0,
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFD9F5F8),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Divider(
                          color: Color(0xFFFC8B8E),
                          thickness: 2,
                          indent: 16,
                          endIndent: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('2x Hamburger'),
                              Text('24₺'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
