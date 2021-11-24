import 'package:flutter/material.dart';
import 'package:flutter_microsoft_authentication/flutter_microsoft_authentication.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class Profile extends StatefulWidget {
  final value;
  Profile({Key key, this.value}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String userName = '';
  String token = '';
  String _authToken = 'Unknown Auth Token';
  FlutterMicrosoftAuthentication fma;

  var res;

  Future<void> _signOut() async {
    String authToken;
    try {
      authToken = await this.fma.signOut;
    } on PlatformException catch (e) {
      authToken = 'Failed to sign out.';
      print(e.message);
    }
    setState(() {
      _authToken = authToken;
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    userName = widget.value['userName'];
    token = widget.value['tokenValue'];
    res = widget.value['microsoftInfo'];
    _authToken = widget.value['tokenValue'];
    super.initState();
    fma = FlutterMicrosoftAuthentication(
        kClientID: "<client-id>",
        kAuthority: "https://login.microsoftonline.com/organizations",
        kScopes: ["User.Read", "User.ReadBasic.All"],
        androidConfigAssetPath: "assets/android_auth_config.json");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: _signOut,
                  icon: Icon(
                    Icons.logout_outlined,
                    color: Colors.red,
                    size: 30.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage('assets/images/profile.jpg'),
                            fit: BoxFit.cover)),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              userName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "Email : ${res.email}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "Given Name : ${res.givenName}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "Surname : ${res.surname}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "DisplayName : ${res.displayName}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "UserName : $userName",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "Mobile phone : ${res.mobilePhone}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "Job title : ${res.jobTitle}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "Favorite language : ${res.favoriteLanguage}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "Office location : ${res.officeLocation}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "User id : ${res.id}",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  "Token Value : $token",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }
}
