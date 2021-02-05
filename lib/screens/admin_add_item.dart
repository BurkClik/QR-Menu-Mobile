import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_mobile/services/admin_provider.dart';
import 'package:qr_mobile/services/storage_service.dart';
import 'package:qr_mobile/theme/constants.dart';
import 'package:qr_mobile/theme/size_config.dart';
import 'package:qr_mobile/widgets/sign_input_area.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'dart:ui';

class AdminAddItem extends StatefulWidget {
  @override
  _AdminAddItemState createState() => _AdminAddItemState();
}

class _AdminAddItemState extends State<AdminAddItem> {
  String dropdownValue = 'Pizza';
  File _image;
  final picker = ImagePicker();

  String url;

  final TextEditingController productController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();

  final imageURL =
      'https://firebasestorage.googleapis.com/v0/b/qrdemo-f252e.appspot.com/o/image_picker7003807406404042762.jpg?alt=media&token=b590a375-139a-410c-b12e-3d616531e23c';
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print('Image Path $_image');
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadPic(BuildContext context) async {
    String filename = basename(_image.path);
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(filename);
    UploadTask uploadTask = firebaseStorageRef.putFile(_image);
    TaskSnapshot taskSnapshot = await uploadTask.snapshot;

    taskSnapshot.ref.getDownloadURL().then((value) => print('Done: $value'));
    url = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      print('Updated');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Updated')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Cafe 236',
          style: kAppBarCafeText,
        ),
        iconTheme: IconThemeData(color: kPrimaryColor),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SignInputArea(
              labelText: "Ürün",
              prefixIcon: Icon(Icons.restaurant),
              textEditingController: productController,
            ),
            SignInputArea(
              labelText: "Fiyat",
              prefixIcon: Icon(Icons.euro),
              textEditingController: priceController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Kategori: ',
                  style: TextStyle(
                    fontFamily: 'Kodchasan',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DropdownButton(
                  value: dropdownValue,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFFFC8B8E),
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: context
                      .read<AdminProvider>()
                      .categories
                      .map<DropdownMenuItem>((e) {
                    return DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'KATEGORİ EKLE',
                      style: TextStyle(
                        fontFamily: 'Kodchasan',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFFC8B8E)),
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: getProportionateScreenWidth(304),
              child: TextFormField(
                maxLines: 8,
                autocorrect: false,
                controller: ingredientsController,
                decoration: InputDecoration(
                  labelText: "İçindekiler",
                  labelStyle: kSignInputLabel,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              child: Container(
                height: getProportionateScreenHeight(200),
                width: getProportionateScreenWidth(304),
                child: _image != null
                    ? Image.file(_image, fit: BoxFit.fill)
                    : Image.asset("assets/icons/default_img.png"),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () {
                getImage();
              },
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('Menu')
                      .doc(dropdownValue)
                      .update({
                    productController.text.trim(): {
                      'image': imageURL,
                      'price': priceController.text.trim(),
                      'name': productController.text.trim(),
                      'ingredients': ingredientsController.text.trim(),
                    }
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${productController.text.trim()} menüye eklendi'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  print(e.message);
                }
              },
              child: Text(
                'EKLE',
                style: TextStyle(
                  fontFamily: 'Kodchasan',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFFC8B8E),
                minimumSize: Size(180, 42),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
