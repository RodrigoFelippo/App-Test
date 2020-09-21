import 'package:app_test/helpers/color_utils.dart';
import 'package:app_test/helpers/constants.dart';
import 'package:flutter/material.dart';

void onLoading(context) {

  //settings AlertDialog
  AlertDialog alert = AlertDialog(
      title: Text(Constants.loading_message,
        style: TextStyle(
            color: ColorUtils.primaryColor,
            fontSize: 17.0
        ),
      ),
      content: LinearProgressIndicator()
  );

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}