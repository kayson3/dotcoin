// ignore_for_file: prefer_const_constructors

import 'package:dotcoin/coincloud/tab.dart';
import 'package:dotcoin/global.dart';
import 'package:dotcoin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Bal extends StatefulWidget {
  Bal({Key? key, this.swap, this.pay}) : super(key: key);
  final swap;
  final String? pay;

  @override
  State<Bal> createState() => _BalState();
}

class _BalState extends State<Bal> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  void showSnackBar(String content) {
    scaffoldState.currentState!.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  @override
  void initState() {
    if (widget.swap != null) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        print(timeStamp);
        dialog1();
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
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
      ),
      body: ListView(padding: EdgeInsets.symmetric(horizontal: 15), children: [
        SizedBox(height: 30),
        Text(
          cryptoListd!.name!,
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
        ),
        SizedBox(height: 40),
        Row(
          children: [
            Text(
              cryptoListd!.cryptoQuantity,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40),
            ),
            Column(children: [
              Text(
                cryptoListd!.cryptoCurrency,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Colors.grey),
              ),
              Text(
                '',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
            ])
          ],
        ),
        Text(
          '0.00 USD',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.grey),
        ),
        SizedBox(height: 60),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          GestureDetector(
            onTap: () {
              bottomSheet('SEND', scaffoldState, context);
            },
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(Icons.arrow_upward_sharp,
                        color: Colors.blue[700], size: 30)),
                SizedBox(height: 10),
                Text('Send')
              ],
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  bottomSheet('RECIEVE', scaffoldState, context);
                },
                child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(Icons.arrow_downward_sharp,
                        color: Colors.blue[700], size: 30)),
              ),
              SizedBox(height: 10),
              Text('Recieve')
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const Tabb(state: TabItem.swap),
                    ),
                  );
                },
                child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(5)),
                    child: Icon(Icons.swap_horiz,
                        color: Colors.blue[700], size: 30)),
              ),
              SizedBox(height: 10),
              Text('Swap')
            ],
          )
        ]),
        SizedBox(height: 30),
        Text(
          'Transactions',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.grey),
        ),
      ]),
    );
  }

  dialog1() {
    var size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: SizedBox(
                  height: size.height / 3.5,
                  width: size.width / 3.5,
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Send ${widget.pay} ${widget.swap['fromCurrency']} to ${widget.swap['payinAddress']}',
                                overflow: TextOverflow.visible,
                                style: TextStyle(fontSize: 20)),
                            Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Text(
                                    'You get ${widget.swap['amount']} ${widget.swap['toCurrency']}',
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(fontSize: 20))),
                            TextButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                    text: widget.swap['payinAddress']
                                        .toString()));

                                Navigator.pop(context);
                                showSnackBar('Copied!!');
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.copy_rounded,
                                        color: Colors.black),
                                    Text('Copy Address',
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(fontSize: 20))
                                  ]),
                            )
                          ]))));
        });
  }
}
