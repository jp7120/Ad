import 'package:admob_demo_2/demo.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';

import 'admob.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BannerAd ads;
  bool isLoading;
  InterstitialAd _interstitialAd;

  @override
  void initState() {
    super.initState();
    ads = BannerAd(
        size: AdSize.banner,
        adUnitId: Admob.bannerAdUnitId,
        listener: AdListener(
            onAdLoaded: (Ad ad) => setState(() {
                  isLoading = true;
                }),
            onAdFailedToLoad: (Ad ad, LoadAdError error) {
              print("Ad Failed to load with error $error");
            },
            onAdClosed: (Ad ad) => print("Ad Closed"),
            onAdOpened: (Ad ad) => print("Ad Opened")),
        request: AdRequest());
    intAd();
    ads.load();
  }

  void dispose() {
    super.dispose();
    ads?.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

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

  Widget checkForAd() {
    if (isLoading == true) {
      return Container(
        child: AdWidget(
          ad: ads,
        ),
        width: ads.size.width.toDouble(),
        height: ads.size.height.toDouble(),
        alignment: Alignment.center,
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 180.0,
            ),
            Text("Hello Haree Prasad"),
            checkForAd(),
            Text("Most Of our ads will go right above this text here"),
            SizedBox(
              height: 100.0,
            ),
            GestureDetector(
              child: Text("Click Me"),
              onTap: () {
                Navigator.of(context).push(PageTransition(
                    child: Demo(), type: PageTransitionType.fade));
              },
            ),
          ],
        ),
      ),
    );
  }
}
