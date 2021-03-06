import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yruwin/models/user_model.dart';
import 'package:yruwin/scaffold/my_service.dart';

import 'package:yruwin/utility/my_style.dart';
import 'package:yruwin/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Explicit
  String? user, password; // default value is null
  final _formKey = GlobalKey<FormState>();
  UserModel? userModel;
  bool? remember = false; // false => unCheck      true = Check

  // Method
  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      user = sharedPreferences.getString('User');
      password = sharedPreferences.getString('Password');

      if (user != null) {
        checkAuthen();
      }
    } catch (e) {}
  }

  Widget rememberCheckbox() {
    return Container(
      width: 250.0,
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text('Remember me'),
        value: remember,
        onChanged: (bool? value) {
          setState(() {
            remember = value;
          });
        },
      ),
    );
  }

  Widget loginButton() {
    return Container(
      width: 250.0,
      child: OutlineButton(
        child: Text(
          'Login',
          style: TextStyle(color: MyStyle().textColor),
        ),
        onPressed: () {
          _formKey.currentState!.save();
          print(
            'user = $user,password = $password',
          );
          checkAuthen();
        },
      ),
    );
  }

  Future<void> checkAuthen() async {
    if (user!.isEmpty || password!.isEmpty) {
      // Have space
      normalDialog(context, 'Have space', 'Please fill all input');
    } else {
      // No space
      String url =
          '${MyStyle().getUserWhereUserAndPass}?username=$user&password=$password';
      final response = await http.get(Uri.parse(url));
      print('url = $url');

      // await ??????????????????????????????????????? await ???????????????????????????????????????????????? process ???????????????
      var result = json.decode(response.body);

      int statusInt = result['status'];
      print('statusInt = $statusInt');

      if (statusInt == 0) {
        String message = result['message'];
        normalDialog(context, 'Login fail', message);
      } else {
        Map<String, dynamic> map = result['data'];
        print('map = $map');
        userModel = UserModel.fromJson(map);

        if (remember!) {
          saveSharePreference();
        } else {
          routeToMyService();
        }
      }
    }
  }

  Future<void> saveSharePreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('User', user!);
    sharedPreferences.setString('Password', password!);

    routeToMyService();
  }

  void routeToMyService() {
    MaterialPageRoute materialPageRoute =
        MaterialPageRoute(builder: (BuildContext buildContext) {
      return MyService(
        userModel: userModel,
      );
    });
    Navigator.of(context).pushAndRemoveUntil(
        materialPageRoute, // pushAndRemoveUntil  clear ???????????????????????????????????? route with out airrow back
        (Route<dynamic> route) {
      return false;
    });
  }

  Widget userForm() {
    return Container(
      width: 250.0,
      child: TextFormField(
        //initialValue: 'nott', // set default value
        onSaved: (String? string) {
          user = string!.trim();
        },
        decoration: InputDecoration(
          labelText: 'User :',
          labelStyle: TextStyle(color: MyStyle().textColor),
        ),
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: 250.0,
      child: TextFormField(
        //initialValue: '123456789', // set default value
        onSaved: (String? string) {
          password = string!.trim();
        },
        obscureText: true, // hide text key replace with
        decoration: InputDecoration(
          labelText: 'Pass :',
          labelStyle: TextStyle(color: MyStyle().textColor),
        ),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Nott PTN',
      style: TextStyle(
        fontSize: MyStyle().h1,
        color: MyStyle().mainColor,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        fontFamily: MyStyle().fontName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.white, MyStyle().bgColor],
              radius: 0.8,
            ),
          ),
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min, //
                  children: <Widget>[
                    showLogo(),
                    showAppName(),
                    userForm(),
                    passwordForm(),
                    rememberCheckbox(),
                    loginButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
