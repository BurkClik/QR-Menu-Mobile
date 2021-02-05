import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_mobile/services/database_stock.dart';
import 'package:qr_mobile/theme/size_config.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:flutter_picker/flutter_picker.dart';

class AdminStock extends StatefulWidget {
  static String routeName = '/AdminStock';

  @override
  _AdminStockState createState() => _AdminStockState();
}

class _AdminStockState extends State<AdminStock> {
  var quantity = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stok',
            style: TextStyle(
              fontFamily: 'Kodchasan',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
            ),
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
                  'Miktar',
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
                  FirebaseFirestore.instance.collection('Stock').snapshots(),
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
                              '${document.data()['product']}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Kodchasan',
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 28),
                            child: Text(
                              '${document.data()['quantity']}',
                              style: TextStyle(
                                fontFamily: 'Kodchasan',
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text('${document.data()['brand']}'),
                      trailing: IconButton(
                        icon: Icon(Icons.add, size: 32, color: Colors.green),
                        onPressed: () async {
                          showMaterialNumberPicker(
                            context: context,
                            minNumber: 1,
                            maxNumber: 100,
                            title: 'Ürün Miktarı',
                            selectedNumber: quantity,
                            onChanged: (value) {
                              setState(() {
                                quantity = value;
                              });
                            },
                            onConfirmed: () async {
                              await DatabaseStock(document.id,
                                      document.data()['quantity'], quantity)
                                  .updateStock();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('$quantity adet eklendi!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                          );
                        },
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
