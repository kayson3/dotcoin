import 'package:dotcoin/global.dart';
import 'package:dotcoin/utils/constants.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_ffi.dart';
import 'package:trust_wallet_core_lib/trust_wallet_core_lib.dart';

class CryptoList {
  String iconLogo;
  String cryptoCurrency;
  String cryptoQuantity;
  String cryptoBalance;
  double percent;
  String? name;
  String? address;

  CryptoList({
    required this.iconLogo,
    required this.cryptoCurrency,
    required this.cryptoQuantity,
    required this.cryptoBalance,
    required this.percent,
    this.name,
    this.address,
  });
}

HDWallet wallet = HDWallet.createWithMnemonic(store.read('walletmnemonic'));

final cryptoList = [
  CryptoList(
      iconLogo: iconCryptoPath[10],
      cryptoCurrency: 'arata',
      cryptoQuantity: store.read('aratabal'),
      cryptoBalance: '\$ 51.423',
      percent: 2.17,
      name: 'ARATA',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypeBinance)),
  CryptoList(
      iconLogo: iconCryptoPath[0],
      cryptoCurrency: 'BTC',
      cryptoQuantity: store.read('btcbal'),
      cryptoBalance: '\$ 51.423',
      percent: 5.17,
      name: 'Bitcoin',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypeBitcoin)),
  CryptoList(
      iconLogo: iconCryptoPath[1],
      cryptoCurrency: 'ETH',
      cryptoQuantity: store.read('ethbal'),
      cryptoBalance: '\$ 638',
      percent: 1.43,
      name: 'Ethereum',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypeEthereum)),
  CryptoList(
      iconLogo: iconCryptoPath[2],
      cryptoCurrency: 'ADA',
      cryptoQuantity: store.read('adabal'),
      cryptoBalance: '\$ 35.672',
      percent: 1.43,
      name: 'Cardano',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypeCardano)),
  CryptoList(
      iconLogo: iconCryptoPath[3],
      cryptoCurrency: 'XRP',
      cryptoQuantity: store.read('xrpbal'),
      cryptoBalance: '\$ 0.45',
      percent: -2.78,
      name: 'Ripple',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypeXRP)),
  CryptoList(
      iconLogo: 'assets/icons/tron.png',
      cryptoCurrency: 'TRX',
      cryptoQuantity: store.read('trxbal'),
      cryptoBalance: '\$ 143.282',
      percent: 5.03,
      name: 'Tron',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypeTron)),
  CryptoList(
      iconLogo: iconCryptoPath[5],
      cryptoCurrency: 'BCH',
      cryptoQuantity: store.read('bchbal'),
      cryptoBalance: '\$ 1.423.282',
      percent: 6.36,
      name: 'BitcoinCash',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypeBitcoinCash)),
  CryptoList(
      iconLogo: 'assets/icons/doge.png',
      cryptoCurrency: 'DOGE',
      cryptoQuantity: store.read('dogebal'),
      cryptoBalance: '\$ 34.148',
      percent: 2.41,
      name: 'DogeCoin',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypeDogecoin)),
  CryptoList(
      iconLogo: 'assets/icons/polygon.png',
      cryptoCurrency: 'MATIC',
      cryptoQuantity: store.read('maticbal'),
      cryptoBalance: '\$ 243.282',
      percent: 31.73,
      name: 'Polygon',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypePolygon)),

  CryptoList(
      iconLogo: 'assets/icons/stellar.png',
      cryptoCurrency: 'XLM',
      cryptoQuantity: store.read('xlmbal'),
      cryptoBalance: '\$ 16.729',
      percent: 15.03,
      name: 'Stellar',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypeStellar)), //438
];

final cryptoListHome = [
  CryptoList(
      iconLogo: iconCryptoPath[0],
      cryptoCurrency: 'BTC',
      cryptoQuantity: '1.24415',
      cryptoBalance: '\$ 51.423',
      percent: 0.00,
      name: 'Bitcoin',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypeBitcoin)),
  CryptoList(
      iconLogo: iconCryptoPath[5],
      cryptoCurrency: 'BCH',
      cryptoQuantity: '1.72839',
      cryptoBalance: '\$ 1.423.282',
      percent: 0.00,
      name: 'BitcoinCash',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypeBitcoinCash)),
  CryptoList(
      iconLogo: iconCryptoPath[1],
      cryptoCurrency: 'ETH',
      cryptoQuantity: '2.15741',
      cryptoBalance: '\$ 638',
      percent: 0.00,
      name: 'Ethereum',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypeEthereum)),
  CryptoList(
      iconLogo: iconCryptoPath[3],
      cryptoCurrency: 'XRP',
      cryptoQuantity: '16.14362',
      cryptoBalance: '\$ 243.282',
      percent: 0.00,
      name: 'Ripple',
      address: store.read('xrpaddress') ?? 'xxxxx'),
  CryptoList(
      iconLogo: iconCryptoPath[7],
      cryptoCurrency: 'LTC',
      cryptoQuantity: '16.14362',
      cryptoBalance: '\$ 243.282',
      percent: 0.00,
      name: 'Litecoin',
      address: store.read('walletmnemonic') == null
          ? 'xxxxx'
          : wallet.getAddressForCoin(TWCoinType.TWCoinTypeLitecoin)),
];
