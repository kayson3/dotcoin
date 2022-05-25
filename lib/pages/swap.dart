// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:dotcoin/coincloud/bal.dart';
import 'package:dotcoin/global.dart';
import 'package:dotcoin/models/models.dart';
import 'package:dotcoin/utils/styles.dart';
import 'package:dotcoin/widgets/cryptoforswap.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../utils/constants.dart';

class Swap extends StatefulWidget {
  const Swap({Key? key}) : super(key: key);

  @override
  _SwapState createState() => _SwapState();
}

class _SwapState extends State<Swap> {
  CryptoList? pay = cryptoList[0];
  CryptoList? get = cryptoList[1];
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  TextEditingController payController = TextEditingController();
  TextEditingController getController = TextEditingController();

  List? searchList;

  showSnackBarr(String content) {
    scaffoldState.currentState!.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }

  @override
  initState() {
    payController.text = '0.00';
    getController.text = '0.00';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
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
                            controller: payController,
                            onFieldSubmitted: (val) {
                              dialog1();
                              if (val.isNotEmpty) {
                                estimatedA().then((value) {});
                              }
                            },
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
                            controller: getController,
                            readOnly: true,
                            cursorColor: deepBlue,
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
        if (payController.text.isNotEmpty) {
          dialog1();
          swapA();
        }
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
                        Navigator.pop(context); //

                      } else if (val == 'get') {
                        setState(() {
                          get = cryptoList[index];
                        });
                        Navigator.pop(context);
                        //dialog1();
                        //minimumA().then((value) {
                        // return null;
                        //});
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

  dialog1() {
    var size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: SizedBox(
                  height: size.height / 5,
                  width: size.width / 5,
                  child: SizedBox(
                      height: size.height / 10,
                      width: size.width / 5,
                      child: Center(child: CircularProgressIndicator()))));
        });
  }

  swapA() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://api.changenow.io/v1/transactions/e70e1eb5e487fbfa4d88d0eb92cea65034616fc49aa3ae447333108d56089d32'));
    request.body = json.encode({
      "from": pay!.cryptoCurrency,
      "to": get!.cryptoCurrency,
      "address": get!.address,
      "amount": payController.text,
      "extraId": "",
      "userId": "",
      "contactEmail": "",
      "refundAddress": "",
      "refundExtraId": ""
    });
    request.headers.addAll(headers);

    http.StreamedResponse response =
        await request.send().onError<SocketException>((error, stackTrace) {
      Navigator.pop(context);
      return showSnackBarr('Network Error');
    });

    http.Response res = await http.Response.fromStream(response);
    print(res.body);
    var results = jsonDecode(res.body);
    Navigator.pop(context);
    if (response.statusCode == 200) {
      cryptoListd = pay;
      print('results');
      print(results);
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>
              Bal(swap: results, pay: payController.text),
        ),
      );
    } else {
      print(response.reasonPhrase);
      print(results);
      showSnackBarr(results["message"].toString());
    }
  }

  Future estimatedA() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.changenow.io/v1/exchange-amount/${payController.text}/${pay!.cryptoCurrency}_${get!.cryptoCurrency}?api_key=e70e1eb5e487fbfa4d88d0eb92cea65034616fc49aa3ae447333108d56089d32'));

    http.StreamedResponse response =
        await request.send().onError<SocketException>((error, stackTrace) {
      Navigator.pop(context);
      return showSnackBarr('Network Error');
    });
    http.Response res = await http.Response.fromStream(response);
    print(res.body);
    var results = jsonDecode(res.body);
    Navigator.pop(context);
    if (response.statusCode == 200) {
      print('results');
      print(results);

      setState(() {
        getController.text = results["estimatedAmount"].toString();
      });
    } else {
      print(response.reasonPhrase);
      print(results);
      showSnackBarr(results["error"].toString());
    }
  }
}
