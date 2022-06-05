import 'dart:io';

import 'package:dotcoin/models/cryptocurrency.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';
import 'dart:convert';

import '../global.dart';
import '../widgets/widgets.dart';

sendArata(context) async {
  send() async {
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

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (results['failed'] == false) {
        sent = true;

        Navigator.pop(context);
        dialog2('Transaction Failed', context);
      }
    } else {
      print(response.statusCode);
      print(response.body);
      sent = false;
      print(results['message']);
      Navigator.pop(context);
      dialog2('Transaction Sucessful', context);
    }
  }

  getPrivateKey() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/bsc/wallet/priv",
    );
    Map<String, dynamic> body = {
      'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
      'mnemonic': store.read('walletmnemonic')
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      store.write('aratapvkey', results['key']);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  if (store.read('aratapvkey') == null) {
    getPrivateKey().then((value) {
      return send();
    });
  } else {
    send();
  }
}

sendBtc(context) {
  send() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/bitcoin/transaction",
    );
    Map<String, dynamic> body = {
      'fromAddress': [
        {"address": cryptoListd!.address, "privateKey": store.read('btcpvkey')}
      ],
      'to': [
        {
          "address": addressController.text,
          "value": amountController.text,
        }
      ]
    };

    http.Response response = await http
        .post(url, body: body)
        .onError<SocketException>((error, stackTrace) {
      Navigator.pop(context);
      return dialog2("Network Error", context);
    });
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (results['failed'] == false) {
        sent = true;
        Navigator.pop(context);
        dialog2('Transaction Failed', context);
      }
    } else {
      print(response.statusCode);
      print(response.body);
      sent = false;
      print(results['message']);
      Navigator.pop(context);
      dialog2('Transaction Sucessful', context);
    }
  }

  getPrivateKey() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/bitcoin/wallet/priv",
    );
    var header = {'Content-Type': 'application/json'};
    var body = {
      'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
      'mnemonic': store.read('walletmnemonic')
    };
    var bodyEncoded = json.encode(body);
    http.Response response =
        await http.post(url, body: bodyEncoded, headers: header);
    print(response.body);
    print('hey');
    debugPrint(response.body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      store.write('btcpvkey', results['key']);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  if (store.read('btcpvkey') == null) {
    getPrivateKey().then((value) {
      return send();
    });
  } else {
    send();
  }
}

sendEth(context) {
  send() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/ethereum/transaction",
    );
    Map<String, String> body = {
      'to': addressController.text, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
      'currency': 'ETH',
      'amount': amountController.text,
      'fromPrivateKey': store.read('ethpvkey')
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (results['failed'] == false) {
        sent = true;
        Navigator.pop(context);
        dialog2('Transaction Failed', context);
      }
    } else {
      print(response.statusCode);
      print(response.body);
      sent = false;
      print(results['message']);
      Navigator.pop(context);
      dialog2('Transaction Sucessful', context);
    }
  }

  getPrivateKey() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/ethereum/wallet/priv",
    );
    Map<String, dynamic> body = {
      'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
      'mnemonic': store.read('walletmnemonic')
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      store.write('ethpvkey', results['key']);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  if (store.read('ethpvkey') == null) {
    getPrivateKey().then((value) {
      return send();
    });
  } else {
    send();
  }
}

sendAda(context) {
  send() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/ada/transaction",
    );
    Map<String, String> body = {
      'to': addressController.text, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
      'currency': 'ETH',
      'amount': amountController.text,
      'fromPrivateKey': store.read('adapvkey')
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (results['failed'] == false) {
        sent = true;
        Navigator.pop(context);
        dialog2('Transaction Failed', context);
      }
    } else {
      print(response.statusCode);
      print(response.body);
      sent = false;
      print(results['message']);
      Navigator.pop(context);
      dialog2('Transaction Sucessful', context);
    }
  }

  getPrivateKey() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/ada/wallet/priv",
    );
    Map<String, dynamic> body = {
      'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
      'mnemonic': store.read('walletmnemonic')
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      store.write('adapvkey', results['key']);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  if (store.read('adapvkey') == null) {
    getPrivateKey().then((value) {
      return send();
    });
  } else {
    send();
  }
}

generateXRP() async {
  if (store.read('xrpaddress') == null) {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/xrp/account",
    );
    http.Response response = await http.get(url);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      store.write('xrpaddress', results['address']);
      store.write('xrppvkey', results['key']);
    } else {
      print(response.statusCode);
      print(response.body);

      print(results['message']);
    }
  }
}

sendXrp(context) {
  send() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/xrp/transaction",
    );
    Map<String, String> body = {
      'to': addressController.text, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
      'fromSecret': store.read('xrppvkey'),
      'amount': amountController.text,
      "fromAccount": store.read('xrpaddress')
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (results['failed'] == false) {
        sent = true;
        Navigator.pop(context);
        dialog2('Transaction Failed', context);
      }
    } else {
      print(response.statusCode);
      print(response.body);
      sent = false;
      print(results['message']);
      Navigator.pop(context);
      dialog2('Transaction Sucessful', context);
    }
  }

  if (store.read('xrppvkey') == null) {
  } else {
    send();
  }
}

sendTron(context) {
  send() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/tron/transaction",
    );
    Map<String, String> body = {
      'to': addressController.text, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0

      'amount': amountController.text,
      'fromPrivateKey': store.read('tronpvkey')
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (results['failed'] == false) {
        sent = true;
        Navigator.pop(context);
        dialog2('Transaction Failed', context);
      }
    } else {
      print(response.statusCode);
      print(response.body);
      sent = false;
      print(results['message']);
      Navigator.pop(context);
      dialog2('Transaction Sucessful', context);
    }
  }

  getPrivateKey() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/tron/wallet/priv",
    );
    Map<String, dynamic> body = {
      'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
      'mnemonic': store.read('walletmnemonic')
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      store.write('tronpvkey', results['key']);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  if (store.read('tronpvkey') == null) {
    getPrivateKey().then((value) {
      return send();
    });
  } else {
    send();
  }
}

sendBch(context) {
  send() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/tron/transaction",
    );
    Map<String, dynamic> body = {
      'fromAddress': [
        {
          'address': cryptoListd!.address,
          'index': 0,
          "privateKey": store.read('bchpvkey'),
        }
      ],
      'to': [
        {
          "address": addressController.text,
          "value": amountController.text,
        }
      ],
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (results['failed'] == false) {
        sent = true;
        Navigator.pop(context);
        dialog2('Transaction Failed', context);
      }
    } else {
      print(response.statusCode);
      print(response.body);
      sent = false;
      print(results['message']);
      Navigator.pop(context);
      dialog2('Transaction Sucessful', context);
    }
  }

  getPrivateKey() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/bcash/wallet/priv",
    );
    Map<String, dynamic> body = {
      'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
      'mnemonic': store.read('walletmnemonic')
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      store.write('bchpvkey', results['key']);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  if (store.read('bchpvkey') == null) {
    getPrivateKey().then((value) {
      return send();
    });
  } else {
    send();
  }
}

sendDoge(context) {
  send() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/dogecoin/transaction",
    );
    Map<String, dynamic> body = {
      'changeAddress': cryptoListd!.address,
      'fromAddress': [
        {
          'value': amountController.text,
          'address': cryptoListd!.address,
          'index': 0,
          "privateKey": store.read('dogepvkey'),
        }
      ],
      "to": [
        {
          'address': addressController.text,
          'value': amountController.text,
        }
      ]
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (results['failed'] == false) {
        sent = true;
        Navigator.pop(context);
        dialog2('Transaction Failed', context);
      }
    } else {
      print(response.statusCode);
      print(response.body);
      sent = false;
      print(results['message']);
      Navigator.pop(context);
      dialog2('Transaction Sucessful', context);
    }
  }

  getPrivateKey() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/dogecoin/wallet/priv",
    );
    Map<String, dynamic> body = {
      'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
      'mnemonic': store.read('walletmnemonic')
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      store.write('dogepvkey', results['key']);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  if (store.read('dogepvkey') == null) {
    getPrivateKey().then((value) {
      return send();
    });
  } else {
    send();
  }
}

sendMatic(context) {
  send() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/polygon/transaction",
    );
    Map<String, String> body = {
      'to': addressController.text, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
      'currency': "MATIC",
      'amount': amountController.text,
      'fromPrivateKey': store.read('maticpvkey')
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (results['failed'] == false) {
        sent = true;
        Navigator.pop(context);
        dialog2('Transaction Failed', context);
      }
    } else {
      print(response.statusCode);
      print(response.body);
      sent = false;
      print(results['message']);
      Navigator.pop(context);
      dialog2('Transaction Sucessful', context);
    }
  }

  getPrivateKey() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/polygon/wallet/priv",
    );
    Map<String, dynamic> body = {
      'index': 0, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
      'mnemonic': store.read('walletmnemonic')
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      store.write('maticpvkey', results['key']);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  if (store.read('maticpvkey') == null) {
    getPrivateKey().then((value) {
      return send();
    });
  } else {
    return send();
  }
}

sendXlm(context) {
  send() async {
    Uri url = Uri.http(
      "api-eu1.tatum.io", //https://pro-api.coinmarketcap.com
      "/v3/xlm/transaction",
    );
    Map<String, String> body = {
      "fromAccount": cryptoListd!.address!,
      'to': addressController.text, //554e2ac4-9e3e-4429-b115-6fe1b2f733d0

      'amount': amountController.text,
      'fromSecret': store.read('xlmpvkey')
    };

    http.Response response = await http.post(url, body: body);
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (results['failed'] == false) {
        sent = true;
        Navigator.pop(context);
        dialog2('Transaction Failed', context);
      }
    } else {
      print(response.statusCode);
      print(response.body);
      sent = false;
      print(results['message']);
      Navigator.pop(context);
      dialog2('Transaction Sucessful', context);
    }
  }

  getPrivateKey() async {
    PrivateKey pvkey =
        wallet.getKey(TWCoinType.TWCoinTypeStellar, "m/44'/148'/0'/0'");

    store.write('xlmpvkey', pvkey.data().toString());
  }

  if (store.read('xlmpvkey') == null) {
    getPrivateKey().then((value) {
      return send();
    });
  } else {
    return send();
  }
}
