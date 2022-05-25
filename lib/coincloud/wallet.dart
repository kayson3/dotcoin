// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dotcoin/coincloud/bal.dart';
import 'package:dotcoin/coincloud/coinDetail.dart';
import 'package:dotcoin/coincloud/importwalle.dart';
import 'package:dotcoin/global.dart';
import 'package:dotcoin/models/cryptocurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print(store.read('walletmnemonic'));
    return store.read('walletmnemonic') == null
        ? Scaffold(
            key: scaffoldState,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text('Wallets',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 25)),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                      dialog();
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 10),
                        child: Row(children: [
                          Image.asset('assets/images/dot.png',
                              height: 50, width: 40),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Create a new wallet',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20)),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 10,
                                width: MediaQuery.of(context).size.width - 100,
                                child: Text("Send and recieve crypto",
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
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 10),
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
                ],
              ),
            ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Text('Wallets',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 25)),
            ),
            body: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: cryptoList.map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () {
                      cryptoListd = e;
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Bal(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Image.asset(e.iconLogo, height: 50, width: 40),
                        SizedBox(width: 15),
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
                        Text(
                          e.cryptoQuantity,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
  }

  dialog() {
    HDWallet wallet = HDWallet();
    store.write('walletmnemonic', wallet.mnemonic());
    print(wallet.mnemonic());
    String phrase = wallet.mnemonic();

    void showSnackBar(String content) {
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

                      showSnackBar('Copied!!');
                      Navigator.pop(context);
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

                              showSnackBar('Copied!!');
                              Navigator.pop(context);
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
