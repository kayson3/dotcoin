// ignore_for_file: prefer_const_constructors

import 'package:dotcoin/global.dart';
import 'package:dotcoin/models/cryptocurrency.dart';
import 'package:dotcoin/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Sltc extends StatelessWidget {
  const Sltc({Key? key, String? this.state}) : super(key: key);

  final state;

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
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Select Coin',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 27)),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: cryptoList.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: GestureDetector(
                      onTap: () {
                        cryptoListd = e;
                        if (state == 'RECIEVE') {
                          bottomSheet('RECIEVE', scaffoldState, context);
                        } else {
                          bottomSheet('SEND', scaffoldState, context);
                        }
                      },
                      child: Row(
                        children: [
                          Image.asset(e.iconLogo, height: 50, width: 40),
                          SizedBox(width: 25),
                          Text(
                            e.name!,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 17),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
