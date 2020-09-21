import 'package:app_test/UI/views/task_list_view.dart';
import 'package:app_test/UI/widgets/custom_progress_dialog.dart';
import 'package:app_test/core/callbacks/login_view_interface.dart';
import 'package:app_test/core/view_models/login_view_model.dart';
import 'package:app_test/helpers/color_utils.dart';
import 'package:app_test/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GreetingsView extends StatefulWidget {
  @override
  _GreetingsViewState createState() => _GreetingsViewState();
}

class _GreetingsViewState extends State<GreetingsView> implements LoginViewInterface{

  LoginViewModel _loginViewModel;

  @override
  void initState() {
    super.initState();
    _loginViewModel = LoginViewModel(this);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle bottomTextStyle = TextStyle(
        color: Colors.white,
        fontStyle: FontStyle.normal,
        fontSize: 10.0
    );

    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: ColorUtils.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: Constants.start_title_message,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                ),
                children: <TextSpan>[
                  TextSpan(text: Constants.developer_name_message, style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: Constants.end_title_message),
                ],
              ),
            ),
            OutlineButton(
              child: Text(Constants.enter_application_message, style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0
              )
              ),
              borderSide: BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              onPressed: (){
                onLoading(context);
                _loginViewModel.gitHubLogin();
              }
            ),
            Column(
              children: [
                Text(Constants.repository_message,
                    style: bottomTextStyle
                ),
                InkWell(
                    child: Text(Constants.repository_link_message, style: bottomTextStyle),
                    onTap: () => launch(Constants.repository_link_message),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showSuccessLoginDialog(BuildContext context, String accessToken) async {

    _loginViewModel.setReceivedTokenStatus(true);

    Widget cancelButton = FlatButton(
        child: Text(Constants.cancel_message,
            style: TextStyle(
                color: ColorUtils.secondaryColor
            )
        ),
        onPressed: (){
          _loginViewModel.setReceivedTokenStatus(false);
          Navigator.of(context).pop();
        }
    );

    Widget confirmButton = FlatButton(
        child: Text(Constants.keep_message,
          style: TextStyle(
              color: ColorUtils.secondaryColor
          ),
        ),
        onPressed:  () {
          _loginViewModel.setReceivedTokenStatus(false);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskListView()),
          );
        }
    );

    //settings AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Constants.github_login_success_message,
        style: TextStyle(
            color: ColorUtils.primaryColor,
            fontSize: 17.0
        ),
      ),
      content: Text(Constants.access_token_message + accessToken,
          style: TextStyle(
              color: ColorUtils.primaryColor
          ),
      ),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );

    //show dialog
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }

  Future<void> _showFailureLoginDialog(BuildContext context, String messageError) async {

    Widget cancelButton = FlatButton(
        child: Text(Constants.cancel_message,
            style: TextStyle(
                color: ColorUtils.secondaryColor
            )
        ),
        onPressed: (){
          Navigator.of(context).pop();
        }
    );

    //settings AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(Constants.login_error_message,
        style: TextStyle(
            color: ColorUtils.primaryColor,
            fontSize: 17.0
        ),
      ),
      content: Text(messageError,
        style: TextStyle(
            color: ColorUtils.primaryColor
        ),
      ),
      actions: [
        cancelButton
      ],
    );

    //show dialog
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );

  }

  @override
  void onSuccessLogin(String accessToken) {
    //Dismiss loading dialog
    Navigator.pop(context);

    _showSuccessLoginDialog(context, accessToken);
  }

  @override
  void onFailureLogin(String messageError) {
    //Dismiss loading dialog
    Navigator.pop(context);

    _showFailureLoginDialog(context, messageError);
  }

}