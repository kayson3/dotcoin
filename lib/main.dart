// ignore_for_file: prefer_const_constructors

import 'package:dotcoin/coincloud/tab.dart';
import 'package:dotcoin/coincloud/welcome.dart';
import 'package:dotcoin/global.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

enum Themee { light, dark, system }
String? selectedTheme;
void main() async {
  await GetStorage.init();
  // configureDependencies();

  TrustWalletCoreLib.init();
  if (store.read('selectedTheme') == null) {
    store.write('selectedTheme', 'Themee.system');
  }
  selectedTheme = store.read('selectedTheme');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(store.read('firstLaunch'));
    print(selectedTheme);
    return MaterialApp(
      themeMode: selectedTheme == 'Themee.system'
          ? ThemeMode.system
          : selectedTheme == 'Themee.dark'
              ? ThemeMode.dark
              : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Dotcoin',

      theme: ThemeData(
          brightness: selectedTheme == 'Themee.dark'
              ? Brightness.dark
              : Brightness.light,
          primaryColor: deepBlue,
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            color: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
          )),
      home: store.read('firstLaunch') == null
          ? Welcome()
          : Tabb(), //WelcomePage(),
    );
  }
}
