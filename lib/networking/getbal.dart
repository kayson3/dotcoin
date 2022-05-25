import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:io';

getBal() async {
  Uri url = Uri.http(
      "sandbox-api.coinmarketcap.com", //https://pro-api.coinmarketcap.com
      "/v1/cryptocurrency/quotes/latest",
      {
        "symbol": 'BTC,BCH,ETH,XRP,LTC',
        "convert": 'USD',
      });
  Map<String, String> header = {
    'X-CMC_PRO_API_KEY':
        'b54bcf4d-1bca-4e8e-9a24-22ff2c3d462c' //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
  };

  http.Response response = await http.get(url, headers: header);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print(response.statusCode);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}
