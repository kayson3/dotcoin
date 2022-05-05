import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotcoin/models/models.dart';
import 'package:get_storage/get_storage.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';

final store = GetStorage();

Color blue = Color(0xFF29abe2);
Color deepBlue = Color(0xFF1b1464);

int pagee = 1;
CryptoList? cryptoListd;
String address = 'kvfnodjfnovnfbnfnjdnfjf';
bool firstLaunch = false;

box() {
  store.write('firstLaunch', false);
  print(store.read('firstLaunch'));
  //aa.remove('quote');

  store.write('wallet', true);
  print(store.read('wallet'));
  //aa.remove('quote');
}
