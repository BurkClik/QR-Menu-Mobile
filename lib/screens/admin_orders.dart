import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminOrders extends StatelessWidget {
  bool typeCheck(String type) {
    if (type == 'Yeni Sipariş!') {
      return true;
    }
    return false;
  }

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
              child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Orders')
                .orderBy("time", descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> demo = document.data()['order'];
                  return new Padding(
                    padding: EdgeInsets.only(top: 12.0),
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
                        ],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${document.data()['tableNumber']}',
                              style: TextStyle(
                                fontFamily: 'Kodchasan',
                              ),
                            ),
                            Container(
                              width: 120,
                              child: Text(
                                '${document.data()['orderType']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Kodchasan',
                                ),
                              ),
                            ),
                            Container(
                              width: 120,
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                '${document.data()['status']}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Kodchasan',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12.0,
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFD9F5F8),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ],
                        ),
                        children: typeCheck(document.data()['orderType']) ==
                                false
                            ? [SizedBox()]
                            : [
                                Divider(
                                  color: Color(0xFFFC8B8E),
                                  thickness: 2,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: demo['itemList'].length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${demo['itemList'][index]['piece']}x ${demo['itemList'][index]['item']['name']}',
                                              style: TextStyle(
                                                  fontFamily: 'Kodchasan',
                                                  fontSize: 12),
                                            ),
                                            Text(
                                              '${(demo['itemList'][index]['item']['price']) * demo['itemList'][index]['piece']}',
                                              style: TextStyle(
                                                  fontFamily: 'Kodchasan',
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          )),
        ],
      ),
    );
  }
}
