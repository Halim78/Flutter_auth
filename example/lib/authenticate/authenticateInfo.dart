import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_microsoft_authentication_example/models/authentication_info.dart';
import 'package:flutter_microsoft_authentication_example/profile/profile.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_microsoft_authentication/flutter_microsoft_authentication.dart';

class AuthenticateInfo extends StatefulWidget {
  @override
  _AuthenticateInfoState createState() => _AuthenticateInfoState();
}

class _AuthenticateInfoState extends State<AuthenticateInfo> {
  String _graphURI = "https://graph.microsoft.com/v1.0/me/";

  String _authToken = 'Unknown Auth Token';
  String _username = 'No Account';
  String _msProfile = 'Unknown Profile';
  List<AuthenticationInfo> microsoftInfo = [];

  FlutterMicrosoftAuthentication fma;

  @override
  void initState() {
    super.initState();

    fma = FlutterMicrosoftAuthentication(
        kClientID: "<client-id>",
        kAuthority: "https://login.microsoftonline.com/organizations",
        kScopes: ["User.Read", "User.ReadBasic.All"],
        androidConfigAssetPath: "assets/android_auth_config.json");
    print('INITIALIZED FMA');
  }

  Future<void> _acquireTokenInteractively() async {
    String authToken;
    try {
      authToken = await this.fma.acquireTokenInteractively;
    } on PlatformException catch (e) {
      authToken = 'Failed to get token.';
      print(e.message);
    }
    setState(() {
      _authToken = authToken;
      this._fetchMicrosoftProfile(_authToken);
    });
  }

  Future<void> _acquireTokenSilently() async {
    String authToken;
    try {
      authToken = await this.fma.acquireTokenSilently;
    } on PlatformException catch (e) {
      authToken = 'Failed to get token silently.';
      print(e.message);
    }
    setState(() {
      _authToken = authToken;
    });
  }

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
    });
  }

  Future _loadAccount() async {
    String username = await this.fma.loadAccount;
    setState(() {
      _username = username;
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new Profile(value: {
                  "tokenValue": _authToken,
                  "userName": _username,
                  "microsoftInfo": microsoftInfo[0]
                })),
      );
    });
  }

  _fetchMicrosoftProfile(userToken) async {
    print('000 $userToken');
    var response = await http
        .get(this._graphURI, headers: {"Authorization": "Bearer " + userToken});

    setState(() {
      _msProfile = json.decode(response.body).toString();
      microsoftInfo.insert(
          0, AuthenticationInfo.fromJson(jsonDecode(response.body)));
      inspect(microsoftInfo[0]);
      this._loadAccount();
    });
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
              height: 150,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 10),
              child: ElevatedButton(
                onPressed: _acquireTokenInteractively,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTH6otc4wbEVZxC4lDW7FwXpU9vUMeTIVPAk9yXM0EJ91fvXVivR3L-HT6clmp1vCXRBLE&usqp=CAU',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Container(
                        child: Text("MICROSOFT"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 20),
              child: ElevatedButton(
                onPressed: null,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Image.network(
                            'https://cdn.pixabay.com/photo/2015/05/17/10/51/facebook-770688_960_720.png',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Container(
                        child: Text("FACEBOOK"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 20),
              child: ElevatedButton(
                onPressed: null,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Image.network(
                            'https://media.lesechos.com/api/v1/images/view/5fb137038fe56f488d0987c6/1280x720/0604269767526-web-tete.jpg',
                            height: 40,
                            width: 70,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 35,
                      ),
                      Container(
                        child: Text("GOOGLE"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
