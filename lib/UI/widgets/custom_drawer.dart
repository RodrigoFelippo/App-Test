import 'package:app_test/helpers/color_utils.dart';
import 'package:app_test/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget> [
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0) ,
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                        top: 8.0,
                        left: 0.0,
                        child: Text(Constants.app_bar_message,
                          style: TextStyle(
                              fontSize: 34.0,
                              fontWeight: FontWeight.bold,
                              color: ColorUtils.primaryColor
                          ),
                        )
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
