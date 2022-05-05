// ignore_for_file: prefer_const_constructors

import 'package:dotcoin/coincloud/tab.dart';
import 'package:dotcoin/global.dart';
import 'package:dotcoin/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Bal extends StatefulWidget {
  const Bal({Key? key}) : super(key: key);

  @override
  State<Bal> createState() => _BalState();
}

class _BalState extends State<Bal> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

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
}
