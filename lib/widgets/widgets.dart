// ignore_for_file: prefer_const_constructors

import 'package:dotcoin/coincloud/tab.dart';
import 'package:dotcoin/global.dart';
import 'package:dotcoin/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../networking/sendCoin.dart';

Future sendTransaction(context) async {
  cryptoListd!.cryptoCurrency == 'BTC'
      ? sendBtc(context)
      : cryptoListd!.cryptoCurrency == 'arata'
          ? sendArata(context)
          : cryptoListd!.cryptoCurrency == 'ETH'
              ? sendEth(context)
              : cryptoListd!.cryptoCurrency == 'ADA'
                  ? sendAda(context)
                  : cryptoListd!.cryptoCurrency == 'XRP'
                      ? sendXrp(context)
                      : cryptoListd!.cryptoCurrency == 'TRX'
                          ? sendTron(context)
                          : cryptoListd!.cryptoCurrency == 'BCH'
                              ? sendBch(context)
                              : cryptoListd!.cryptoCurrency == 'DOGE'
                                  ? sendDoge(context)
                                  : cryptoListd!.cryptoCurrency == 'XLM'
                                      ? sendMatic(context)
                                      : cryptoListd!.cryptoCurrency == 'MATIC'
                                          ? sendMatic(context)
                                          : null;
}

Widget floatingButton(
    {Color? color, required String text, bool? pressed, context}) {
  return ElevatedButton(
    onPressed: () {
      if (text == 'SEND') {
        sent = false;
        dialog1(context);
        sendTransaction(context);
      }
      if (pressed!) {
        print(text);

        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>
                const Tabb(state: TabItem.wallet),
          ),
        );
      }
    },
    style: ElevatedButton.styleFrom(primary: color, elevation: 5),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: customText(
        '$text',
        20,
        baseColor,
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

TextEditingController amountController = TextEditingController();
TextEditingController addressController = TextEditingController();
void bottomSheet(text, key, context) {
  void showSnackBar(String content) {
    key.currentState!.showSnackBar(
      SnackBar(
        content: Text(content),
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
            height: text == 'SEND'
                ? MediaQuery.of(context).size.height / 1.2
                : MediaQuery.of(context).size.height / 2.0,
            child: text == 'RECIEVE'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text('Address',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w600)),
                          ),
                        ),
                        Icon(Icons.qr_code_2, size: 250),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                  ),
                                  child: Text(cryptoListd!.address!,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white))),
                            ),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: cryptoListd!.address));

                                showSnackBar('Copied!!');
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                child: Text('copy',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                            'Send only ${cryptoListd!.cryptoCurrency} to this address',
                            style: TextStyle(fontSize: 17))
                      ])
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10, top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text('Send',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600)),
                        ),
                        SizedBox(height: 25),
                        TextFormField(
                          controller: amountController,
                          keyboardType: TextInputType.numberWithOptions(),
                          validator: (val) {
                            return val!.length < 0
                                ? null
                                : 'must exceed 0 characters';
                          },
                          //controller: phoneController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            labelStyle: TextStyle(color: deepBlue),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: deepBlue),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            //enabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: deepBlue),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: addressController,
                          validator: (val) {
                            return val!.length > 8
                                ? null
                                : 'Address must exceed 8 characters';
                          },
                          //controller: addController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            labelText: 'Address',
                            labelStyle: TextStyle(color: deepBlue),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: deepBlue),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            //enabledBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: deepBlue),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                          ),
                        ),
                        const SizedBox(height: 30),
                        floatingButton(
                          text: 'SEND',
                          color: deepBlue,
                          pressed: false,
                          context: context,
                        ),
                        SizedBox(height: 5),
                        Text(
                            'Make sure its a valid ${cryptoListd!.cryptoCurrency} address',
                            style: TextStyle(fontSize: 17))
                      ],
                    ),
                  ));
      });
}

d() {
  PreferredSize(
      preferredSize: Size.fromHeight(100.0),
      child: SafeArea(
          top: true,
          child: Container(
              height: 50,
              color: Colors.grey[400],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 100,
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: TextFormField(
                              textInputAction: TextInputAction.send,
                              decoration:
                                  InputDecoration(border: InputBorder.none))))
                ],
              ))));
}

dialog1(context) {
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

dialog2(content, context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
            title: Text(content),
            alignment: Alignment.bottomRight,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                      color: deepBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      wordSpacing: 5),
                ),
              )
            ]);
      });
}
