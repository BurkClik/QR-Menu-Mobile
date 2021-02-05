import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:qr_mobile/theme/constants.dart';
import 'package:qr_mobile/widgets/daily_container.dart';
import 'package:qr_mobile/widgets/last_order.dart';
import 'package:qr_mobile/widgets/pop_orders.dart';

class AdminHome extends StatefulWidget {
  static String routeName = '/AdminHome';

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Future<int> countOrder() async {
    QuerySnapshot _myDoc =
        await FirebaseFirestore.instance.collection('Orders').get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    return _myDocCount.length;
  }

  Future<double> sumPrice() async {
    double sum = 0;
    QuerySnapshot _deneme = await FirebaseFirestore.instance
        .collection('Orders')
        .where("orderType", isEqualTo: "Yeni Sipariş!")
        .get();

    List<DocumentSnapshot> _myDoc = _deneme.docs;
    _myDoc.forEach((element) {
      sum += element.data()['order']['price'];
    });
    return sum;
  }

  void getStock() async {
    Map<String, dynamic> _nasip;
    QuerySnapshot _deneme = await FirebaseFirestore.instance
        .collection('Stock')
        .where("quantity", isLessThan: 50)
        .limit(3)
        .get();
    List<DocumentSnapshot> _myDoc = _deneme.docs;
    _myDoc.forEach((element) {
      print(element.data()["product"]);
      _nasip["${element.data()["product"]}"] = element.data()["quantity"];
    });
    print(_nasip["Bilmem ne"]);
  }

  @override
  Widget build(BuildContext context) {
    getStock();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FutureBuilder(
                future: sumPrice(),
                builder:
                    (BuildContext context, AsyncSnapshot<double> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return DailyContainer(
                      dailyText: 'Toplam Kazanç',
                      dailyCount: '${snapshot.data}₺');
                },
              ),
              FutureBuilder(
                  future: countOrder(),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return DailyContainer(
                        dailyText: 'Sipariş Sayısı',
                        dailyCount: '${snapshot.data}');
                  }),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 16.0),
            child: Text(
              'Son Siparişler',
              style: TextStyle(
                fontFamily: 'Kodchasan',
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Orders')
                  .orderBy("time", descending: true)
                  .limit(1)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> demo = document.data();
                    return new ListView.builder(
                        itemCount: 2,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          print(index);
                          return new LastOrder(
                            url: demo['order']['itemList'][0]['item']['image'],
                            price: demo['order']['itemList'][0]['item']
                                ['price'],
                            productName: demo['order']['itemList'][0]['item']
                                ['name'],
                            status: demo['status'],
                          );
                        });
                  }).toList(),
                );
              }),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 16.0),
            child: Text(
              'Stok Bilgisi',
              style: TextStyle(
                fontFamily: 'Kodchasan',
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 120),
                      Text(
                        'Ürün',
                        style: kTableTitle,
                      ),
                      SizedBox(width: 52),
                      Text(
                        'Adet',
                        style: kTableTitle,
                      ),
                    ],
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Stock')
                        .where("quantity", isLessThan: 100)
                        .limit(5)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 2.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.warning,
                                    size: 16,
                                    color: kPrimaryColor,
                                  ),
                                  SizedBox(width: 84),
                                  Container(
                                    width: 112,
                                    child: Text(
                                      '${document.data()['product']}',
                                      overflow: TextOverflow.ellipsis,
                                      style: kTableCellStyle,
                                    ),
                                  ),
                                  Text(
                                    '${document.data()['quantity']}',
                                    style: kTableCellStyle,
                                  ),
                                ],
                              ),
                            );
                          }).toList());
                    },
                  ),
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
