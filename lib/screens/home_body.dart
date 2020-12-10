import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_mobile/demo.dart';
import 'package:qr_mobile/theme/constants.dart';
import 'package:qr_mobile/theme/size_config.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String orderFirebaseIcon(String order) {
    switch (order) {
      case 'Garson Çağırıyor!':
        return "mobile_hand";
        break;
      case 'Hesap (Nakit)!':
        return "credit-card";
        break;
      case 'Hesap (Kart)!':
        return "credit-card";
        break;
      case 'Sipariş Hazır!':
        return "mobile_basket";
        break;
      case 'Yeni Sipariş!':
        return "icons8-waiter";
        break;
      default:
        return "icons8-waiter";
    }
  }

  Color orderFirebaseColor(String order) {
    switch (order) {
      case 'Garson Çağırıyor!':
        return Color(0xFFFFE5E6);
        break;
      case 'Hesap (Nakit)!':
        return Color(0xFFD9F5F8);
        break;
      case 'Hesap (Kart)!':
        return Color(0xFFD9F5F8);
        break;
      case 'Sipariş Hazır!':
        return Color(0xFFFFEDD9);
        break;
      case 'Yeni Sipariş!':
        return Color(0xFFECEAFF);
        break;
      default:
        return Colors.black;
    }
  }

  int orderFirebaseTime(int order) {
    // TODO: The difference should be dynamic.
    var date = DateTime.now();
    /* Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {});
    }); */
    Duration difference =
        date.difference(DateTime.fromMicrosecondsSinceEpoch(order * 1000));
    return difference.inMinutes;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: getProportionateScreenHeight(40.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 28.0, bottom: 20.0),
            child: Text(
              'Son Aktiviteler',
              style: kLastActivitiesText,
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Orders')
                  .orderBy("time", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return new ListView(
                  physics: BouncingScrollPhysics(),
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new Padding(
                      padding: EdgeInsets.only(
                          left: 28.0, right: 28.0, bottom: 20.0),
                      child: Container(
                        height: getProportionateScreenHeight(80.0),
                        decoration: BoxDecoration(
                          color:
                              orderFirebaseColor(document.data()['orderType']),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [kItemBoxShadow],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SvgPicture.asset(
                              "assets/icons/${orderFirebaseIcon(document.data()['orderType'])}.svg",
                              width: 52,
                              height: 52,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: getProportionateScreenWidth(180.0),
                                  child: Text(
                                    "Masa ${document.data()['tableNumber']} - ${document.data()['orderType']}",
                                    style: kOrderDetailText,
                                  ),
                                ),
                                Text(
                                  "${orderFirebaseTime(document.data()['time'])} dakika",
                                  style: kOrderTimeText,
                                )
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                print(auth.currentUser.displayName);
                                print(auth.currentUser.email);
                              },
                              icon: SvgPicture.asset(
                                "assets/icons/tick.svg",
                                width: 32,
                                height: 32,
                                color: Color(0xFF019A5A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
