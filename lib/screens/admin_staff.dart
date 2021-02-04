import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
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
            padding: const EdgeInsets.only(top: 16.0, left: 16.0),
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
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Staff').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return new ListTile(
                      title: Row(
                        children: [
                          Container(
                            width: 156,
                            child: Text(
                              '${document.data()['fullName']}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Kodchasan',
                              ),
                            ),
                          ),
                          Text(
                            '${document.data()['phoneNumber']}',
                            style: TextStyle(
                              fontFamily: 'Kodchasan',
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.settings,
                        color: Color(0xFFFC8B8E),
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
