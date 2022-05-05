// ignore_for_file: prefer_const_constructors

import 'package:dotcoin/coincloud/tab.dart';
import 'package:dotcoin/coincloud/welcome.dart';
import 'package:dotcoin/global.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

void main() async {
  // configureDependencies();

  TrustWalletCoreLib.init();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(store.read('firstLaunch'));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dotcoin',
      theme: ThemeData(
          primaryColor: deepBlue,
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            color: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          )),
      home: store.read('firstLaunc') == null
          ? Welcome()
          : Tabb(), //WelcomePage(),
    );
  }
}
