import 'package:flutter/material.dart';
import 'package:qr_mobile/theme/constants.dart';
import 'package:qr_mobile/widgets/daily_container.dart';
import 'package:qr_mobile/widgets/last_order.dart';
import 'package:qr_mobile/widgets/pop_orders.dart';

class AdminHome extends StatelessWidget {
  static String routeName = '/AdminHome';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DailyContainer(dailyText: 'Günlük Kazanç', dailyCount: '10369'),
              DailyContainer(dailyText: 'Günlük Sipariş', dailyCount: '369'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              'Son Siparişler',
              style: TextStyle(
                fontFamily: 'Kodchasan',
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          LastOrder(),
          LastOrder(),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              'Popüler Siparişler',
              style: TextStyle(
                fontFamily: 'Kodchasan',
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              child: Table(
                border: TableBorder.all(
                    color: Colors.black, style: BorderStyle.none),
                children: [
                  TableRow(children: [
                    TableCell(
                        child: Center(child: Text('Ürün', style: kTableTitle))),
                    TableCell(
                        child:
                            Center(child: Text('Sipariş', style: kTableTitle))),
                    TableCell(
                        child:
                            Center(child: Text('Kazanç', style: kTableTitle))),
                  ]),
                  buildTableRow(),
                  buildTableRow(),
                  buildTableRow(),
                  buildTableRow(),
                  buildTableRow(),
                  buildTableRow(),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 2, color: Color(0xFFFC8B8E)),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TableRow buildTableRow() {
    return TableRow(children: [
      TableCell(
        child: Center(child: Text('Alinin Makarnası', style: kTableCellStyle)),
        verticalAlignment: TableCellVerticalAlignment.bottom,
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(child: Text('42', style: kTableCellStyle)),
      ),
      TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Center(child: Text('630₺', style: kTableCellStyle)),
      ),
    ]);
  }
}
