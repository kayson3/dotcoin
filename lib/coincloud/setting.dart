import 'package:dotcoin/coincloud/importwalle.dart';
import 'package:dotcoin/models/cryptocurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../global.dart';
import '../main.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  String selectedThemee = store.read('selectedTheme') == 'Themee.light'
      ? 'light'
      : store.read('selectedTheme') == 'Themee.dark'
          ? 'dark'
          : 'System Default';

  @override
  initState() {
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
          title: Text('Settings',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 25)),
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            children: [
              SizedBox(height: 20),
              Text('General',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 25)),
              SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Icon(Icons.color_lens_rounded, color: Colors.grey),
                SizedBox(width: 20),
                Text('Theme',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 20)),
                Spacer(),
                DropdownButton<String>(
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      fontSize: 19),
                  value: selectedThemee,
                  /*hint: Text(product.cartQuantity.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      )),*/
                  icon: const Icon(Icons.keyboard_arrow_down_sharp,
                      color: Colors.grey),
                  items: <String>['light', 'dark'].map((String value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                        ));
                  }).toList(),
                  onChanged: (value) {
                    value == 'System Default'
                        ? store
                            .write('selectedTheme', 'Themee.system')
                            .then((value) => setState(() {
                                  selectedThemee =
                                      store.read('selectedTheme') ==
                                              'Themee.light'
                                          ? 'light'
                                          : store.read('selectedTheme') ==
                                                  'Themee.dark'
                                              ? 'dark'
                                              : 'System Default';
                                }))
                        : value == 'light'
                            ? store
                                .write('selectedTheme', 'Themee.light')
                                .then((value) => setState(() {
                                      selectedThemee =
                                          store.read('selectedTheme') ==
                                                  'Themee.light'
                                              ? 'light'
                                              : store.read('selectedTheme') ==
                                                      'Themee.dark'
                                                  ? 'dark'
                                                  : 'System Default';
                                    }))
                            : store
                                .write('selectedTheme', 'Themee.dark')
                                .then((value) => setState(() {
                                      selectedThemee =
                                          store.read('selectedTheme') ==
                                                  'Themee.light'
                                              ? 'light'
                                              : store.read('selectedTheme') ==
                                                      'Themee.dark'
                                                  ? 'dark'
                                                  : 'System Default';
                                    }));

                    print(store.read('selectedTheme'));
                  },
                ),
              ]),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {},
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.monetization_on_rounded, color: Colors.grey),
                      SizedBox(width: 20),
                      Text('Display Currency',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 20)),
                      Spacer(),
                      DropdownButton<String>(
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                            fontSize: 19),
                        value: currency,
                        /*hint: Text(product.cartQuantity.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      )),*/
                        icon: const Icon(Icons.keyboard_arrow_down_sharp,
                            color: Colors.grey),
                        items:
                            <String>['USD', 'ESR', 'JPN'].map((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ));
                        }).toList(),
                        onChanged: (value) {
                          currency = value!;
                          store.write('currency', currency);
                          setState(() {});
                        },
                      ),
                    ]),
              ),
              SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Icon(Icons.lock, color: Colors.grey),
                SizedBox(width: 20),
                Text('Lock App',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 20)),
                Spacer(),
                Text('Disabled',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontSize: 19)),
                SizedBox(width: 10),
              ]),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  setState(() {
                    toggle = !toggle;
                    store.write('togglee', toggle);
                  });
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.remove_red_eye_sharp, color: Colors.grey),
                      SizedBox(width: 20),
                      Text('Show Portfolio Value',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 20)),
                      Spacer(),
                      toggle
                          ? Icon(Icons.toggle_on, size: 35)
                          : Icon(Icons.toggle_off, size: 35),
                      SizedBox(width: 10),
                    ]),
              ),
              SizedBox(height: 30),
              Text('Cypto Wallets & Keys',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 25)),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ImportW(),
                    ),
                  );
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.download, color: Colors.grey),
                      SizedBox(width: 20),
                      Text('Import Wallet',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 20)),
                      Spacer(),
                    ]),
              ),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  dialog();
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.copy_rounded, color: Colors.grey),
                      SizedBox(width: 10),
                      Text('Copy Mnemonic',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 20)),
                      Spacer(),
                    ]),
              ),
              SizedBox(height: 25),
              Text('More',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 25)),
              SizedBox(height: 25),
              GestureDetector(
                onTap: () {
                  SystemNavigator.pop();
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.exit_to_app, color: Colors.grey),
                      SizedBox(width: 20),
                      Text('Exit',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 20)),
                      Spacer(),
                    ]),
              ),
              SizedBox(height: 25),
            ]));
  }

  dialog() {
    void showSnackBarr(String content) {
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
                      Clipboard.setData(ClipboardData(text: wallet.mnemonic()));

                      Navigator.pop(context);
                      showSnackBarr('Copied!!');
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
                              Clipboard.setData(
                                  ClipboardData(text: wallet.mnemonic()));

                              Navigator.pop(context);
                              showSnackBarr('Copied!!');
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
