// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:dotcoin/coincloud/importwalle.dart';
import 'package:dotcoin/coincloud/tab.dart';
import 'package:dotcoin/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late HDWallet wallet;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  void initState() {
    print(store.read('firstLaunch'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: ListView(
            children: [
              Text('How do you want to get started?',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 27)),
              SizedBox(
                height: 20,
              ),
              Text("We'll streamline your setup experience accordingly.",
                  style: TextStyle(color: Colors.black, fontSize: 19)),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  dialog();
                  //print(wallet.getAddressForCoin(TWCoinType.TWCoinTypeEthereum));
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/dot.png',
                              width: 70, height: 70),
                          SizedBox(height: 10),
                          Text("Create me a new wallet",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 20)),
                          SizedBox(height: 2),
                          Text(
                              "To receive and send Dotcoin and other digital currency",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17)),
                        ])),
              ),
              SizedBox(height: 12),
              Row(children: [
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("or",
                      style: TextStyle(color: Colors.grey, fontSize: 17)),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
              ]),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ImportW(),
                    ),
                  );
                },
                child: Card(
                  elevation: 9,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                    child: Row(children: [
                      Icon(Icons.cloud_download,
                          size: 30, color: Colors.greenAccent),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Import an existing wallet',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20)),
                          SizedBox(height: 10),
                          SizedBox(
                            height: 10,
                            width: MediaQuery.of(context).size.width - 100,
                            child: Text(
                                "Add funds from an existing wallet using your 12 word recovery key",
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 17)),
                          ),
                          SizedBox(height: 10)
                        ],
                      )
                    ]),
                  ),
                ),
              ),
              SizedBox(height: 60),
              TextButton(
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const Tabb(),
                      ),
                    );
                  },
                  child: Center(
                    child: Text("Continue to app",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: deepBlue, fontSize: 17)),
                  )),
              SizedBox(height: 20),
            ],
          ),
        ));
  }

  dialog() {
    HDWallet wallet = HDWallet();
    store.write('walletmnemonic', wallet.mnemonic());
    print(wallet.mnemonic());
    String phrase = wallet.mnemonic();

    void showSnackBarr(String content) {
      scaffoldState.currentState!.showSnackBar(
        SnackBar(
          content: Text(content),
          duration: const Duration(milliseconds: 200),
        ),
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(title: Text('Recovery Phrase'), children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 185, 182, 182),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text(
                        wallet.mnemonic(),
                        style: TextStyle(
                            color: deepBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            wordSpacing: 5),
                      )),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: phrase));

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const Tabb(),
                        ),
                      );
                      showSnackBarr('Copied!!');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'COPY',
                          style: TextStyle(
                            color: deepBlue,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: phrase));

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const Tabb(),
                                ),
                              );
                              showSnackBarr('Copied!!');
                            },
                            icon: Icon(Icons.copy, size: 20, color: deepBlue))
                      ],
                    ),
                  )
                ],
              ),
            )
          ]);
        });
  }
}
