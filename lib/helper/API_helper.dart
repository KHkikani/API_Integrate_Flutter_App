import 'dart:convert';
import 'package:api_integrate/model/user.dart';
import 'package:http/http.dart' as http;

class APIhelper {
  static String url = "reqres.in";

  static Future<List<User>?> getUserList({required String page}) async {
    String path = "/api/users";
    Map<String, dynamic> query = {"page": page};

    Uri uri = Uri.https(url, path, query);

    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);

      List<User> allUser = [];

      jsonMap['data'].forEach((element) {
        allUser.add(User.fromJSON(data: element));
      });

      return allUser;
    } else {
      return null;
    }
  }
}
