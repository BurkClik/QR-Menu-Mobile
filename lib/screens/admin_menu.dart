import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_mobile/screens/admin_add_item.dart';
import 'package:qr_mobile/services/admin_provider.dart';
import 'package:qr_mobile/theme/size_config.dart';
import 'package:provider/provider.dart';

class AdminMenu extends StatelessWidget {
  List<dynamic> demo = [];

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
            padding: const EdgeInsets.only(top: 16.0, left: 16.0),
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
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Menu').snapshots(),
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
                    Map<String, dynamic> menu = document.data();
                    if (!demo.contains(document.id)) {
                      demo.add(document.id);
                      context.read<AdminProvider>().changeList(demo);
                    }
                    return new ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: menu.keys.length,
                        itemBuilder: (context, index) {
                          String key = menu.keys.elementAt(index);

                          return ListTile(
                            title: Row(
                              children: [
                                Container(
                                  width: 156,
                                  child: Text(
                                    '$key',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Kodchasan',
                                    ),
                                  ),
                                ),
                                Text(
                                  '${document.id}',
                                  style: TextStyle(fontFamily: 'Kodchasan'),
                                ),
                              ],
                            ),
                            trailing: Icon(
                              Icons.settings,
                              color: Color(0xFFFC8B8E),
                            ),
                          );
                        });
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
