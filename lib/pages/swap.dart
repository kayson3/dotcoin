// ignore_for_file: prefer_const_constructors

import 'package:dotcoin/global.dart';
import 'package:dotcoin/models/models.dart';
import 'package:dotcoin/utils/styles.dart';
import 'package:dotcoin/widgets/cryptoforswap.dart';

import 'package:flutter/material.dart';

class Swap extends StatefulWidget {
  const Swap({Key? key}) : super(key: key);

  @override
  _SwapState createState() => _SwapState();
}

class _SwapState extends State<Swap> {
  CryptoList? pay = cryptoList[0];
  CryptoList? get = cryptoList[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Swap',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 25)),
        ),
        body: Column(children: [
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('You Pay',
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            cursorColor: deepBlue,
                            initialValue: '0',
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusColor: deepBlue)),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            dialog('pay');
                          },
                          child: Image.asset(pay!.iconLogo,
                              height: 45, width: 45)),
                      SizedBox(width: 5),
                      GestureDetector(
                          onTap: () {
                            dialog('pay');
                          },
                          child: Text(pay!.name!.toUpperCase())),
                      SizedBox(width: 5),
                      GestureDetector(
                          onTap: () {
                            dialog('pay');
                          },
                          child: Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text('Balance: ${pay!.cryptoQuantity} ${pay!.cryptoCurrency}',
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 5),
                  Text('You Get',
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            cursorColor: deepBlue,
                            initialValue: '0',
                            decoration:
                                InputDecoration(border: InputBorder.none)),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            dialog('get');
                          },
                          child: Image.asset(get!.iconLogo,
                              height: 45, width: 45)),
                      SizedBox(width: 5),
                      GestureDetector(
                          onTap: () {
                            dialog('get');
                          },
                          child: Text(get!.name!.toUpperCase())),
                      SizedBox(width: 5),
                      GestureDetector(
                          onTap: () {
                            dialog('get');
                          },
                          child: Icon(Icons.arrow_forward_ios_rounded,
                              color: Colors.black)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text('Balance: ${get!.cryptoQuantity} ${get!.cryptoCurrency}',
                      style: TextStyle(
                          fontSize: 17,
                          color: primaryColor,
                          fontWeight: FontWeight.w600)),
                ],
              )),
          SizedBox(height: 10),
          _floatingButton(color: deepBlue, text: 'Swap'),
        ]));
  }

  Widget _floatingButton({Color? color, required String text, bool? pressed}) {
    return ElevatedButton(
      onPressed: () {
        if (pressed!) {}
      },
      style: ElevatedButton.styleFrom(primary: color, elevation: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: customText(
          text,
          20,
          Colors.white,
          FontWeight.w700,
        ),
      ),
    );
  }

  Widget customText(
    String text,
    double fontSize,
    Color color,
    FontWeight fontWeight,
  ) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }

  dialog(val) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 25),
            height: MediaQuery.of(context).size.height / 2,
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: cryptoList.length,
                itemBuilder: (context, index) {
                  final _cryptoList = cryptoList[index];
                  return GestureDetector(
                    onTap: () {
                      if (val == 'pay') {
                        setState(() {
                          pay = cryptoList[index];
                        });
                        Navigator.pop(context);
                      } else {
                        setState(() {
                          get = cryptoList[index];
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: CardCrypto(cryptoList: _cryptoList),
                    ),
                  );
                }),
          );
        });
  }
}
