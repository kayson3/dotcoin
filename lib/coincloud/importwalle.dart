// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dotcoin/coincloud/tab.dart';
import 'package:dotcoin/coincloud/welcome.dart';
import 'package:dotcoin/global.dart';
import 'package:dotcoin/utils/styles.dart';
import 'package:dotcoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class ImportW extends StatefulWidget {
  const ImportW({Key? key}) : super(key: key);

  @override
  _ImportWState createState() => _ImportWState();
}

class _ImportWState extends State<ImportW> {
  TextEditingController phrase = TextEditingController();

  @override
  void initState() {
    ////FlutterTrustWalletCore.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.pop(context);
            },
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          ),
          centerTitle: true,
          title: Text('Import Wallet',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 25)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                  'Type or enter your recovery phrase to import your wallet bellow:',
                  style: TextStyle(color: Colors.grey[700], fontSize: 17)),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextFormField(
                      style: TextStyle(fontSize: 17),
                      controller: phrase,
                      maxLines: 12,
                      decoration: InputDecoration(border: InputBorder.none))),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  if (phrase.text.isNotEmpty) {
                    try {
                      HDWallet wallet =
                          HDWallet.createWithMnemonic(phrase.text.trim());
                      store.write('walletmnemonic', wallet.mnemonic());
                      print(wallet
                          .getAddressForCoin(TWCoinType.TWCoinTypeEthereum));
                    } on Exception catch (e) {
                      print(e.toString());

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SimpleDialog(
                                title: Text(e.toString()),
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('OK',
                                                style: TextStyle(
                                                    color: deepBlue,
                                                    fontWeight:
                                                        FontWeight.bold))
                                          ]),
                                    ),
                                  )
                                ]);
                          });

                      return null;
                    }

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const Tabb(state: TabItem.wallet),
                      ),
                    );
                  }
                },
                style:
                    ElevatedButton.styleFrom(primary: deepBlue, elevation: 5),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: customText(
                    'Import Wallet',
                    20,
                    baseColor,
                    FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
