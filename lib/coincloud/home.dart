// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:dotcoin/coincloud/coinDetail.dart';
import 'package:dotcoin/coincloud/selectcoin.dart';
import 'package:dotcoin/global.dart';
import 'package:dotcoin/models/cryptocurrency.dart';
import 'package:dotcoin/utils/styles.dart';
import 'package:dotcoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:http/http.dart' as http;

import '../main.dart';
import '../networking/getbal.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  @override
  initState() {
    store.write('firstLaunch', false);
    store.read('togglee') ?? store.write('togglee', false);
    store.read('currency') ?? store.write('currency', 'USD');
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      print(timeStamp);
      getCryptoStats();
    });
    super.initState();
  }

  Future getCryptoStats() async {
    Uri url = Uri.http(
        "sandbox-api.coinmarketcap.com", //https://pro-api.coinmarketcap.com
        "/v1/cryptocurrency/quotes/latest",
        {
          "symbol": 'BTC,BCH,ETH,XRP,LTC',
          "convert": 'USD',
        });
    Map<String, String> header = {
      'X-CMC_PRO_API_KEY':
          '554e2ac4-9e3e-4429-b115-6fe1b2f733d0' //554e2ac4-9e3e-4429-b115-6fe1b2f733d0
    };

    http.Response response = await http
        .get(url, headers: header)
        .onError<SocketException>(
            (error, stackTrace) => showSnackBarr('Network Error'));
    var results = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.statusCode);
      for (var i = 0; i < cryptoListHome.length; i++) {
        if (cryptoListHome[i].cryptoCurrency == 'BTC') {
          double percentt =
              results['data']['BTC']["quote"]["USD"]["percent_change_24h"];
          cryptoListHome[i].percent = double.parse(percentt.toStringAsFixed(2));
        } else if (cryptoListHome[i].cryptoCurrency == 'BCH') {
          double percentt =
              results['data']['BCH']["quote"]["USD"]["percent_change_24h"];
          cryptoListHome[i].percent = double.parse(percentt.toStringAsFixed(2));
        } else if (cryptoListHome[i].cryptoCurrency == 'ETH') {
          double percentt =
              results['data']['ETH']["quote"]["USD"]["percent_change_24h"];
          cryptoListHome[i].percent = double.parse(percentt.toStringAsFixed(2));
        } else if (cryptoListHome[i].cryptoCurrency == 'XRP') {
          double percentt =
              results['data']['XRP']["quote"]["USD"]["percent_change_24h"];
          cryptoListHome[i].percent = double.parse(percentt.toStringAsFixed(2));
        } else if (cryptoListHome[i].cryptoCurrency == 'LTC') {
          double percentt =
              results['data']['LTC']["quote"]["USD"]["percent_change_24h"];
          cryptoListHome[i].percent = double.parse(percentt.toStringAsFixed(2));
        }
      }
      setState(() {});
    } else {
      print(response.statusCode);
      print(response.body);
      showSnackBarr(response.body);
    }
  }

  showSnackBarr(String content) {
    scaffoldState.currentState!.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        backgroundColor: selectedTheme == 'Themee.dark'
            ? Color.fromARGB(232, 31, 31, 31)
            : Colors.white,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(5), child: Container()),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: RefreshIndicator(
              onRefresh: () {
                getBal().then((_) {
                  setState(() {});
                });
                return getCryptoStats();
              },
              child: ListView(
                children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: SafeArea(
                            top: true,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Image.asset('assets/images/S.png',
                                  width: 150),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text("Total cash value",
                            style: TextStyle(color: Colors.grey, fontSize: 17)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: !store.read('togglee')
                            ? Text('**** ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 27))
                            : Text('0.00 ${store.read('currency')}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 27)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text("last 24h",
                            style: TextStyle(color: Colors.grey, fontSize: 17)),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const Sltc(state: 'SEND'),
                                    ),
                                  );
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Icon(Icons.arrow_upward,
                                        color: Colors.blue[700], size: 40)),
                              ),
                              SizedBox(height: 17),
                              Text(
                                'Send',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const Sltc(state: 'RECIEVE'),
                                    ),
                                  );
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Icon(Icons.qr_code,
                                        color: Colors.blue[700], size: 40)),
                              ),
                              SizedBox(height: 17),
                              Text(
                                'Receive',
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Text('Exchange Rates',
                          style:
                              TextStyle(fontSize: 17, color: Colors.grey[500])),
                      SizedBox(height: 10),
                    ] +
                    cryptoListHome.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            cryptoListd = e;
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const Details(),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Image.asset(e.iconLogo, height: 50, width: 40),
                              SizedBox(width: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    e.name!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    e.cryptoCurrency,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    e.cryptoBalance,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    e.percent > 0
                                        ? '+' + e.percent.toString() + '%'
                                        : '-' + e.percent.toString() + '%',
                                    style: TextStyle(
                                      color:
                                          e.percent > 0 ? buyColor : sellColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ));
  }
}
