// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:dotcoin/coincloud/home.dart';
import 'package:dotcoin/coincloud/selectcoin.dart';
import 'package:dotcoin/coincloud/wallet.dart';
import 'package:dotcoin/global.dart';
import 'package:dotcoin/models/cryptocurrency.dart';
import 'package:dotcoin/pages/dapp.dart';

import 'package:dotcoin/pages/swap.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../../widgets/widgets.dart';

enum TabItem { home, wallet, trade, swap, dapp }

class Tabb extends StatefulWidget {
  const Tabb({Key? key, this.state}) : super(key: key);
  final TabItem? state;

  @override
  _TabbState createState() => _TabbState();
}

class _TabbState extends State<Tabb> {
  late TabItem _current;
  @override
  initState() {
    store.write('firstLaunch', false);
    print('htuuu');
    if (widget.state != null) {
      _current = widget.state!;
    } else {
      _current = TabItem.home;
    }
    super.initState();
    print('htuu2u');
  }

  final List<TabItem> _tabs = [
    TabItem.home,
    TabItem.wallet,
    TabItem.trade,
    TabItem.swap,
    TabItem.dapp
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('d');
        if (pagee == 1) {
          return true;
        }
        pagee = 1;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const Tabb(),
          ),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: _buildNavPage(),
        bottomNavigationBar: _bottomNavBar(),
      ),
    );
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
      items: _tabs.map((tabItem) {
        return _bottomNavBarItems(
            _icon(tabItem),
            tabItem,
            tabItem.index == 0
                ? 'Home'
                : tabItem.index == 1
                    ? 'Wallet'
                    : tabItem.index == 2
                        ? 'Trade'
                        : tabItem.index == 3
                            ? 'Swap'
                            : 'Dapp');
      }).toList(),
      onTap: _selectTab,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: Colors.grey,
      selectedLabelStyle: TextStyle(color: Colors.grey),
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      type: BottomNavigationBarType.fixed,
    );
  }

  BottomNavigationBarItem _bottomNavBarItems(
      IconData icon, TabItem tabItem, String label) {
    final Color color = _current == tabItem ? deepBlue : colorLight;
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: color,
        ),
        label: label);
  }

  void _selectTab(int index) {
    pagee = 1;
    TabItem selectTabItem = _tabs[index];
    setState(() {
      if (selectTabItem != TabItem.trade) {
        _current = selectTabItem;
      }
    });
    if (selectTabItem == TabItem.trade) {
      bottomSheet();
    }
  }

  IconData _icon(TabItem item) {
    switch (item) {
      case TabItem.home:
        return Icons.home;
      case TabItem.wallet:
        return Icons.account_balance_wallet;
      case TabItem.trade:
        return Icons.model_training_rounded;
      case TabItem.swap:
        return Icons.swap_horiz;
      case TabItem.dapp:
        return Icons.apps_sharp;

      default:
        throw 'Unknown $item';
    }
  }

  Widget _buildNavPage() {
    switch (_current) {
      case TabItem.home:
        return const Home();
      case TabItem.wallet:
        return const Wallet();

      case TabItem.swap:
        return const Swap();
      case TabItem.dapp:
        return Dapp();

      default:
        return Home();
    }
  }

  bottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        enableDrag: true,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(13),
            topRight: Radius.circular(13),
          ),
        ),
        builder: (BuildContext context) {
          return SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const Sltc(state: 'RECIEVE'),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.arrow_downward_sharp,
                                    color: Colors.blue[700], size: 30)),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Recieve',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20)),
                                Text('Get crypto from another wallet',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.grey))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const Sltc(state: 'SEND'),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.arrow_upward_sharp,
                                    color: Colors.blue[700], size: 30)),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Send',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20)),
                                Text('Send crypto to another wallet',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.grey))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _current = _tabs[3];
                          });
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue[100],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.swap_horiz,
                                    color: Colors.blue[700], size: 30)),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Swap',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20)),
                                Text('Swap crypto for another',
                                    style: TextStyle(
                                        fontSize: 17, color: Colors.grey))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[700],
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Center(
                                child: Text('x',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 40)),
                              ),
                            )),
                      ),
                    )
                  ]));
        });
  }
}
