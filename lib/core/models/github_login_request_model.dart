class GitHubLoginRequestModel {
  String clientId;
  String clientSecret;
  String code;

  GitHubLoginRequestModel({this.clientId, this.clientSecret, this.code});

  dynamic toJson() => {
    "client_id": clientId,
    "client_secret": clientSecret,
    "code": code,
  };
}