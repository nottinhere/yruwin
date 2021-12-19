import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:yruwin/models/user_model.dart';

class Home extends StatefulWidget {
  final UserModel? userModel;
  Home({Key? key, this.userModel}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Explicit
  // List<PromoteModel> promoteModels = List();
  List<Widget>? promoteLists;
  List<String>? urlImages;
  UserModel? myUserModel;

  // Method
  @override
  void initState() {
    super.initState();
    myUserModel = widget.userModel;
  }

  Widget myCircularProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void routeToListProduct(int index) {
    // MaterialPageRoute materialPageRoute =
    //     MaterialPageRoute(builder: (BuildContext buildContext) {
    //   return ListProduct(
    //     index: index,
    //     userModel: myUserModel,
    //   );
    // });
    // Navigator.of(context).push(materialPageRoute);
  }

  Widget uListcomplaint() {
    // String login = myUserModel.subject;
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      // height: 80.0,
      child: GestureDetector(
        child: Card(
          color: Colors.lightBlue.shade50,
          child: Container(
            padding: EdgeInsets.all(16.0),
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 45.0,
                  child: Image.asset('images/icon_drugs.png'),
                  padding: EdgeInsets.all(8.0),
                ),
                Text(
                  'เรื่องร้องเรียน',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          print('You click product');
          routeToListProduct(0);
        },
      ),
    );
  }

  Widget topRight() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 80.0,
      child: GestureDetector(
        child: Card(
          color: Colors.green.shade100,
          child: Container(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Text(
              'newproduct',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        onTap: () {
          print('You click newproduct');
          routeToListProduct(1);
        },
      ),
    );
  }

  Widget bottomLeft() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 80.0,
      child: GestureDetector(
        child: Card(
          color: Colors.green.shade100,
          child: Container(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Text(
              'updateprice',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        onTap: () {
          print('You click updateprice');
          routeToListProduct(2);
        },
      ),
    );
  }

  Widget bottomRight() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 80.0,
      child: GestureDetector(
        child: Card(
          color: Colors.green.shade100,
          child: Container(
            alignment: AlignmentDirectional(0.0, 0.0),
            child: Text(
              'recommend',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        onTap: () {
          print('You click recommend');
          routeToListProduct(3);
        },
      ),
    );
  }

  Widget topMenu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        uListcomplaint(),
        topRight(),
      ],
    );
  }

  Widget bottomMenu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        bottomLeft(),
        bottomRight(),
      ],
    );
  }

  Widget homeMenu() {
    return Container(
      alignment: Alignment(0.0, 0.0),
      color: Colors.grey.shade50,
      height: MediaQuery.of(context).size.height * 0.5 - 81,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          topMenu(),
          bottomMenu(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          homeMenu(),
        ],
      ),
    );
  }
}
