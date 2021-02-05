import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_mobile/screens/admin_add_item.dart';
import 'package:qr_mobile/services/admin_provider.dart';
import 'package:qr_mobile/theme/size_config.dart';
import 'package:provider/provider.dart';
import 'package:qr_mobile/widgets/sign_input_area.dart';

class AdminMenu extends StatefulWidget {
  @override
  _AdminMenuState createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
  List<dynamic> demo = [];

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> _showMyDialog(String url, String productName, int productPrice,
      String documentID, String key) async {
    TextEditingController priceController = TextEditingController();
    TextEditingController nameController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Bilgileri Güncelle')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(url),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.25),
                        )
                      ]),
                ),
                SizedBox(height: 10),
                SignInputArea(
                  prefixIcon: Icon(Icons.restaurant_menu),
                  hintText: productName,
                  textEditingController: nameController,
                ),
                SizedBox(height: 10),
                SignInputArea(
                  prefixIcon: Icon(Icons.lock),
                  hintText: '$productPrice₺',
                  textEditingController: priceController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Onayla'),
              onPressed: () async {
                /*    await FirebaseFirestore.instance
                    .collection('Menu')
                    .doc(documentID)
                    .update({
                  key: FieldValue.arrayUnion([productName, productPrice])
                }); */
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
                            trailing: IconButton(
                              icon: Icon(Icons.settings,
                                  color: Color(0xFFFC8B8E)),
                              onPressed: () {
                                print(menu.values.elementAt(index)['image']);
                                _showMyDialog(
                                  menu.values.elementAt(index)['image'],
                                  menu.values.elementAt(index)['name'],
                                  menu.values.elementAt(index)['price'],
                                  document.id,
                                  key,
                                );
                              },
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
