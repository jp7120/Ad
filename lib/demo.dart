import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'admob.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  InterstitialAd _interstitialAd;
  void intAd() {
    _interstitialAd = InterstitialAd(
        adUnitId: Admob.interstitialAdUnitId,
        listener: AdListener(
            onAdLoaded: (Ad ad) {
              print("${ad.runtimeType} loaded");
            },
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
              print("Ad Failed to load with error $error");
              ad.dispose();
              _interstitialAd = null;
              intAd();
            },
            onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
            onAdClosed: (Ad ad) {
              print("Ad Closed");
              _interstitialAd.dispose();
              _interstitialAd = null;
              intAd();
            },
            onApplicationExit: (Ad ad) {
              print("Application Exited");
              _interstitialAd.dispose();
            }),
        request: AdRequest())
      ..load();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    intAd();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _interstitialAd.show(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Pop Function"),
            automaticallyImplyLeading: false,
          ),
          body: Container(
              color: Colors.amber,
              child: Center(
                child: RaisedButton(
                  child: Text("Go back Dude"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _interstitialAd.show();
                  },
                ),
              )),
        ));
  }
}
