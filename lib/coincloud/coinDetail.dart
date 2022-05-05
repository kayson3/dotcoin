// ignore_for_file: prefer_const_constructors

import 'package:dotcoin/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../widgets/card_statistics.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
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
        title: Text(cryptoListd!.name!,
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 25)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            _cardWallet(
              iconUrl: cryptoListd!.iconLogo,
              crypto: cryptoListd!.name!,
              cryptoSymbol: cryptoListd!.cryptoCurrency,
              totalCrypto: cryptoListd!.cryptoQuantity,
              total: cryptoListd!.cryptoBalance,
              percent: cryptoListd!.percent,
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _chipContainer(textChip: '1D'),
                  Text('7D'),
                  Text('1M'),
                  Text('3M'),
                  Text('1Y'),
                  Text('YTD'),
                  Text('ALL'),
                ],
              ),
            ),
            cardStatistics(
              padding: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${cryptoListd!.cryptoCurrency} to USD Chart',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: primaryColor,
                            letterSpacing: -.6,
                          ),
                        ),
                        Row(
                          children: [
                            _chipContainer(textChip: 'Price'),
                          ],
                        ),
                      ],
                    ), 
                  ),*/
                  SizedBox(
                    height: _size.height / 2.5,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: LineChart(
                            sampleData(),
                          ),
                        ),
                        Positioned(
                          bottom: 45,
                          right: 20,
                          child: Row(
                            children: [
                              Text(
                                'Crypto Market',
                                style: TextStyle(
                                  color: baseColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  letterSpacing: -.8,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child:
                      _floatingButton(text: 'SEND', color: blue, pressed: true),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _floatingButton(
                      text: 'RECIEVE', color: deepBlue, pressed: true),
                ),
              ],
            ), */
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  LineChartData sampleData() {
    return LineChartData(
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          showOnTopOfTheChartBoxArea: true,
          fitInsideVertically: false,
          tooltipRoundedRadius: 20,
        ),
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        topTitles: SideTitles(
          showTitles: false,
        ),
        bottomTitles: SideTitles(
          showTitles: false,
          interval: 4,
          reservedSize: 14,
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: false,
          interval: 1,
          reservedSize: 4,
          margin: 10,
        ),
        rightTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      maxX: 24,
      maxY: 5,
      minY: 1,
      lineBarsData: linesBarData(),
    );
  }

  List<LineChartBarData> linesBarData() {
    return [
      LineChartBarData(
        spots: [
          FlSpot(0, 2),
          FlSpot(6, 2.8),
          FlSpot(8, 2.0),
          FlSpot(10, 2.5),
          FlSpot(14, 3.2),
          FlSpot(16, 2.2),
          FlSpot(18, 2.6),
          FlSpot(24, 5),
        ],
        isCurved: false,
        colors: [
          cryptoListd!.percent >= 0 ? Colors.green : sellColor,
        ],
        barWidth: 3,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          applyCutOffY: true,
          cutOffY: 1,
          gradientFrom: const Offset(1, 1),
          gradientTo: const Offset(1, 0),
          colors: [
            cryptoListd!.percent >= 0 ? Colors.green[200]! : Colors.red[200]!,
            colorGradient2,
          ],
        ),
      ),
    ];
  }

  Widget _chipContainer({String? textChip}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: CHIPDECORATION,
      child: Text(
        textChip!,
        style: TextStyle(color: baseColor, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _cardWallet({
    required String crypto,
    cryptoSymbol,
    iconUrl,
    total,
    totalCrypto,
    required double percent,
  }) {
    return cardStatistics(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('$iconUrl', width: 50),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2),
                    customText(
                      crypto,
                      20,
                      tWalletColor,
                      FontWeight.w700,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      decoration: CHIPDECORATION,
                      child: customText(
                        '$cryptoSymbol',
                        10,
                        baseColor,
                        FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child:
                    Icon(Icons.keyboard_arrow_down, size: 30, color: sellColor),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                    color: percent >= 0 ? buyColor : sellColor,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(
                  percent >= 0 ? '+ $percent %' : '$percent %',
                  style: TextStyle(
                    color: baseColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          customText(
            '$totalCrypto',
            25,
            tWalletColor,
            FontWeight.w700,
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customText(
                '$total',
                15,
                primaryColor,
                FontWeight.w700,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _floatingButton({Color? color, required String text, bool? pressed}) {
    return ElevatedButton(
      onPressed: () {
        if (pressed!) {
          print(text);
          bottomSheet(text);
        }
      },
      style: ElevatedButton.styleFrom(primary: color, elevation: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: customText(
          text,
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

  void bottomSheet(text) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
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
                  : MediaQuery.of(context).size.height / 2.2,
              child: text == 'RECIEVE'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Icon(Icons.qr_code_2, size: 250),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                  ),
                                  child: Text(address,
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.white))),
                              Container(
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
                                          fontSize: 17, color: Colors.white))),
                            ],
                          ),
                          SizedBox(height: 5),
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
                          TextFormField(
                            validator: (val) {
                              return val!.length > 8
                                  ? null
                                  : 'Phone Number must exceed 8 characters';
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
                          _floatingButton(
                            text: 'SEND',
                            color: deepBlue,
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
}
