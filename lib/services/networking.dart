import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final url = new Uri.https(
        "samples.openweathermap.org", "/data/2.5/weather", {
      "lat": "35",
      "lon": "139",
      "appid": "439d4b804bc8187953eb36d2a8c26a02"
    });

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
