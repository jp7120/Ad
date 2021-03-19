import 'dart:io';

class Admob {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-2185159153645267/3735006318';
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/8691691433';
    }
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/5135589807';
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }
}
