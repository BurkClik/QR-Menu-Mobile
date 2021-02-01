import 'package:flutter/material.dart';
import 'package:qr_mobile/theme/constants.dart';
import 'package:qr_mobile/theme/size_config.dart';
import 'package:qr_mobile/widgets/sign_input_area.dart';

enum StaffStatus { Garson, Admin }

class AdminAddStaff extends StatefulWidget {
  @override
  _AdminAddStaffState createState() => _AdminAddStaffState();
}

class _AdminAddStaffState extends State<AdminAddStaff> {
  String dropdownValue = 'Pizza';
  StaffStatus _status = StaffStatus.Garson;

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SignInputArea(
              labelText: "İsim",
              prefixIcon: Icon(Icons.person),
            ),
            SizedBox(height: getProportionateScreenHeight(32)),
            SignInputArea(
              labelText: "Telefon",
              prefixIcon: Icon(Icons.phone),
            ),
            SizedBox(height: getProportionateScreenHeight(32)),
            SignInputArea(
              labelText: "Mail",
              prefixIcon: Icon(Icons.mail),
            ),
            SizedBox(height: getProportionateScreenHeight(32)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: StaffStatus.Admin,
                  groupValue: _status,
                  onChanged: (StaffStatus value) {
                    setState(() {
                      _status = value;
                    });
                  },
                ),
                Text('Admin'),
                SizedBox(width: 32),
                Radio(
                  value: StaffStatus.Garson,
                  groupValue: _status,
                  onChanged: (StaffStatus value) {
                    setState(() {
                      _status = value;
                    });
                  },
                ),
                Text('Garson'),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(32)),
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
