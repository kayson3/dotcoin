import 'dart:io';

import 'package:dotcoin/models/cryptocurrency.dart';
import 'package:http/http.dart' as http;
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'dart:convert';

import '../global.dart';
import '../widgets/widgets.dart';

getTransactions() {
  getTArata();
  getTBtc();
  getTEth();
  getTAda();
  getTXrp();
  getTTron();
  getTBch();
  getTDoge();
  getTMatic();
  getTXlm();
}

getTArata() async {
  getT() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/bsc/transaction",
    );
    Map<String, String> body = {
      'to': addressController.text, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
      'currency': 'ARATA',
      'amount': amountController.text,
      'fromPrivateKey': store.read('aratapvkey')
    };

    http.Response response = await http.get(url);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (results['failed'] == false) {
        sent = true;
      }
    } else {
      print(response.statusCode);
      print(response.body);
      sent = false;
      print(results['message']);
    }
  }
}

getTBtc() async {
  Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/bitcoin/transaction/address/${cryptoListd!.address}",
      {'pageSize': 45});

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('btcT', results);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getTEth() async {
  Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/ethereum/transaction/address/${cryptoListd!.address}",
      {'pageSize': 45});

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('ethT', results);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getTAda() async {
  Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/ada/transaction/address/${cryptoListd!.address}",
      {'pageSize': 45});

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('adaT', results);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getTXrp() async {
  Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/xrp/account/tx/${cryptoListd!.address}",
      {'pageSize': 45});

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('xrpT', results);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getTTron() async {
  Uri url = Uri.http(
    "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
    "/v3/tron/transaction/account/${cryptoListd!.address}",
  );

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('trxT', results);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getTBch() async {
  Uri url = Uri.http(
    "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
    "/v3/bcash/transaction/address/${cryptoListd!.address}",
  );

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('bchT', results);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getTDoge() async {}

getTMatic() async {
  Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/polygon/account/transaction/${cryptoListd!.address}",
      {'pageSize': 45});

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('maticT', results);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}

getTXlm() async {
  Uri url = Uri.http(
    "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
    "/v3/xlm/account/tx/${cryptoListd!.address}",
  );

  http.Response response = await http.get(url);
  var results = jsonDecode(response.body);
  if (response.statusCode == 200) {
    store.write('xlmT', results);
  } else {
    print(response.statusCode);
    print(response.body);
  }
}
