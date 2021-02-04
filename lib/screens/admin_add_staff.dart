import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_mobile/services/authentication_service.dart';
import 'package:qr_mobile/theme/constants.dart';
import 'package:qr_mobile/theme/size_config.dart';
import 'package:qr_mobile/widgets/sign_input_area.dart';
import 'package:provider/provider.dart';

enum StaffStatus { Garson, Admin }

class AdminAddStaff extends StatefulWidget {
  @override
  _AdminAddStaffState createState() => _AdminAddStaffState();
}

class _AdminAddStaffState extends State<AdminAddStaff> {
  String dropdownValue = 'Pizza';
  StaffStatus _status = StaffStatus.Garson;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

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
              textInputType: TextInputType.name,
              textEditingController: nameController,
            ),
            SizedBox(height: getProportionateScreenHeight(32)),
            SignInputArea(
              labelText: "Telefon",
              prefixIcon: Icon(Icons.phone),
              textInputType: TextInputType.phone,
              textEditingController: phoneController,
            ),
            SizedBox(height: getProportionateScreenHeight(32)),
            SignInputArea(
              labelText: "Mail",
              prefixIcon: Icon(Icons.mail),
              textInputType: TextInputType.emailAddress,
              textEditingController: emailController,
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
              onPressed: () async {
                try {
                  await context.read<AuthenticationService>().registerUser(
                        email: emailController.text.trim(),
                        password: "123456",
                        name: nameController.text.trim(),
                        phoneNumber: phoneController.text.trim(),
                      );
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Başarıyla kaydedildi"),
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
