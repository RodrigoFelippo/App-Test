import 'dart:convert';
import 'package:app_test/core/callbacks/login_view_interface.dart';
import 'package:app_test/core/models/github_login_request_model.dart';
import 'package:app_test/helpers/constants.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class LoginViewModel {

  final customUriScheme = Constants.custom_uri_scheme_message;
  final redirectUri = Constants.redirect_uri_message;

  final clientId = Constants.client_id_code_message;
  final String clientSecret = Constants.client_secret_code_message;

  bool receivedTokenStatus = false;

  LoginViewInterface view;
  LoginViewModel(LoginViewInterface view){
    this.view = view;
  }

  void setReceivedTokenStatus(bool receivedTokenStatus){
    this.receivedTokenStatus = receivedTokenStatus;
  }

  void gitHubLogin() async {
    String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" +
        "$clientId" +
        "&scope=public_repo%20read:user%20user:email";

    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );

      getLinksStream().listen((link) async {
        String code = link.substring(link.indexOf(RegExp('code=')) + 5);
        final response = await http.post(
          "https://github.com/login/oauth/access_token",
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
          body: jsonEncode(GitHubLoginRequestModel(
            clientId: clientId,
            clientSecret: clientSecret,
            code: code,
          )),
        );

        Map<String, dynamic> tokenResponse = jsonDecode(response.body);

        String accessToken = tokenResponse['access_token'];

        if(accessToken != null) {
            if (!receivedTokenStatus) {
              view.onSuccessLogin(accessToken);
            }
        } else {
          view.onFailureLogin(Constants.github_login_token_error_message);
        }

      }, cancelOnError: true);
    } else {
      view.onFailureLogin(Constants.github_login_error_message);
    }

  }

}