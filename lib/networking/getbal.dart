import 'package:http/http.dart' as http;
import 'dart:convert';

import '../global.dart';
import '../models/cryptocurrency.dart';

Future getBal() async {
  getbscBal();
  getbtcBal();
  getethBal();
  getadaBal();
  getxrpBal();
  gettrxBal();
  getbchBal();
  getdogeBal();
  getmaticBal();
  getxlmBal();
  return '';
}

getbscBal() async {
  Uri url = Uri.http(
    "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
    "/v3/bsc/account/balance/${cryptoList[0].address}",
  );

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('aratabal', results['balance']);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getbtcBal() async {
  Uri url = Uri.http(
    "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
    "/v3/bitcoin/address/balance/${cryptoList[1].address}",
  );

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('btcbal', results['incoming']);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getethBal() async {
  Uri url = Uri.http(
    "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
    "/v3/ethereum/account/balance/${cryptoList[2].address}",
  );

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('ethbal', results['balance']);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getadaBal() async {
  Uri url = Uri.http(
    "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
    "/v3/ada/account/${cryptoList[3].address}",
  );

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write(
        'adabal', results[0]['summary']['assetBalances'][0]['quantity']);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getxrpBal() async {
  Uri url = Uri.http(
    "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
    "/v3/xrp/account/${cryptoList[4].address}/balance",
  );

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('xrpbal', results['balance']);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

gettrxBal() async {
  Uri url = Uri.http(
    "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
    "/v3/tron/account/${cryptoList[5].address}",
  );

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('trxbal', results['balance']);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getbchBal() async {
  Uri url = Uri.http(
    "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
    "/v3/bitcoin/address/balance/${cryptoList[6].address}",
  );

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('btcbal', results['incoming']);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getdogeBal() async {
  Uri url = Uri.http(
      "block.io", //https://pro-api.coinmarketcap.com
      "/api/v2/get_address_balance",
      {'api_key': 'e07f-8b84-a85f-ff32', 'addresses': cryptoList[7].address});

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('trxbal', results['data']['available_balance']);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getmaticBal() async {
  Uri url = Uri.http(
    "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
    "/v3/polygon/account/balance/${cryptoList[8].address}",
  );

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('maticbal', results['balance']);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getxlmBal() async {
  Uri url = Uri.http(
    "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
    "/v3/xlm/account/${cryptoList[9].address}",
  );

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('xlmbal', results['balances'][0]['balance']);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}
