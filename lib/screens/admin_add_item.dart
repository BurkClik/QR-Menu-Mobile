import 'package:flutter/material.dart';
import 'package:qr_mobile/theme/constants.dart';
import 'package:qr_mobile/theme/size_config.dart';
import 'package:qr_mobile/widgets/sign_input_area.dart';

class AdminAddItem extends StatefulWidget {
  @override
  _AdminAddItemState createState() => _AdminAddItemState();
}

class _AdminAddItemState extends State<AdminAddItem> {
  String dropdownValue = 'Pizza';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  items: ["Pizza", "Hamburger", "Meşrubat", "Dondurma"]
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
                        color: Colors.black,
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
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://source.unsplash.com/random"),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () {
                print("Yeni Resim Gelecek");
              },
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'EKLE',
                style: TextStyle(
                  fontFamily: 'Kodchasan',
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
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
