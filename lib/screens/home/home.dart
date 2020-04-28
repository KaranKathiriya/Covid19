import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:indiacovid19/screens/extra/FAQ.dart';
import 'package:indiacovid19/screens/statedetail/statedetail.dart';
import 'package:indiacovid19/shared/constants.dart';
import 'package:indiacovid19/shared/loading.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class Home extends StatefulWidget {
  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  Home({this.analytics, this.observer});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var api = "https://api.covid19india.org/data.json";
  var res, state;

  static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>[
      'Cases',
      'corona',
      'covid19',
      'virus',
      'india',
      'Aarogya Setu'
    ],
    childDirected: true,
  );

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;

  BannerAd createBannerAd() {
    return new BannerAd(
        adUnitId: "ca-app-pub-3677593423733226/1916723610",
        size: AdSize.banner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print("Banner event : $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return new InterstitialAd(
        adUnitId: "ca-app-pub-3677593423733226/8210669226",
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print("Interstitial event : $event");
        });
  }

  Future<Null> _sendAnalytics() async {
    await widget.analytics
        .logEvent(name: 'full_screen_tapped', parameters: <String, dynamic>{});
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-3677593423733226~8368729123");
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    fetchData();
  }

  fetchData() async {
    res = await http.get(api);
    state = jsonDecode(res.body)['statewise'];
    setState(() {});
  }

  Widget build(BuildContext context) {
    return res == null
        ? Loading()
        : Container(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Center(child: Text("Covid19 info")),
                elevation: 0.0,
                backgroundColor: Colors.black,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      setState(() {
                        res = null;
                      });
                      fetchData();
                    },
                  )
                ],
              ),
              drawer: Drawer(
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Covid19 info',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            '#Stay Home',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            '#Stay Safe',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                    ),
                    ListTile(
                      title: Text('Home'),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: Text('FAQ'),
                      onTap: () {
                        _sendAnalytics();
                        createInterstitialAd()
                          ..load()
                          ..show();
                        Navigator.of(context).pop();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => FAQ()));
                      },
                    ),
                  ],
                ),
              ),
              body: Center(
                  child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "India",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.length,
                        itemBuilder: (context, index) {
                          var states = state[index];
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 150,
                                        height: 150,
                                        child: Card(
                                            shape: cardShape,
                                            child: InkWell(
                                                splashColor:
                                                    Colors.blue.withAlpha(30),
                                                //color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                              Icons
                                                                  .check_circle,
                                                              size: 60),
                                                          Text(
                                                            "Confirmed",
                                                            style: TextStyle(
                                                                fontSize: 23,
                                                                color:
                                                                    Colors.red),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "${states["confirmed"]}",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 20),
                                                          ),
                                                        ]),
                                                  ),
                                                ))),
                                      ),
                                      Container(
                                        height: 150,
                                        width: 150,
                                        child: Card(
                                            shape: cardShape,
                                            child: InkWell(
                                                splashColor:
                                                    Colors.blue.withAlpha(30),
                                                //color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                              Icons
                                                                  .offline_bolt,
                                                              size: 60),
                                                          Text(
                                                            "Active",
                                                            style: TextStyle(
                                                                fontSize: 25,
                                                                color: Colors
                                                                    .blue),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "${states["active"]}",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 20),
                                                          ),
                                                        ]),
                                                  ),
                                                ))),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 150,
                                        height: 150,
                                        child: Card(
                                            shape: cardShape,
                                            child: InkWell(
                                                splashColor:
                                                    Colors.blue.withAlpha(30),
                                                //color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(Icons.history,
                                                              size: 60),
                                                          Text(
                                                            "Recovered",
                                                            style: TextStyle(
                                                                fontSize: 23,
                                                                color: Colors
                                                                    .green),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "${states["recovered"]}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontSize: 20),
                                                          ),
                                                        ]),
                                                  ),
                                                ))),
                                      ),
                                      Container(
                                        width: 150,
                                        height: 150,
                                        child: Card(
                                            shape: cardShape,
                                            child: InkWell(
                                                splashColor:
                                                    Colors.blue.withAlpha(30),
                                                //color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Icon(
                                                              Icons
                                                                  .highlight_off,
                                                              size: 60),
                                                          Text(
                                                            "Deaths",
                                                            style: TextStyle(
                                                                fontSize: 23,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            "${states["deaths"]}",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 20),
                                                          ),
                                                        ]),
                                                  ),
                                                ))),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            60, 0, 0, 0),
                                        child: Text(
                                          "Confirmed: +${states["deltaconfirmed"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10.0, 0, 0, 0),
                                        child: Text(
                                          "Recovered: +${states["deltarecovered"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10.0, 0, 0, 0),
                                        child: Text(
                                          "Deaths: +${states["deltadeaths"]}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Last Updated: ${states["lastupdatedtime"]}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "Click on State for district wise details",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 0),
                              child: Card(
                                  shape: cardShape,
                                  color: Colors.grey[100],
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      _sendAnalytics();
                                      createInterstitialAd()
                                        ..load()
                                        ..show();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => StateDetail(
                                                    state: states,
                                                  )));
                                    },
                                    child: Column(children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "${states["state"]}",
                                          style: TextStyle(
                                            fontSize: 22,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              //spacing: 0,
                                              children: <Widget>[
                                                Text(
                                                  "Confirmed",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${states["confirmed"]}",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                  "Active",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${states["active"]}",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              //spacing: 0,
                                              children: <Widget>[
                                                Text(
                                                  "Recovered",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 15),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${states["recovered"]}",
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              //spacing: 0,
                                              children: <Widget>[
                                                Text("Deaths"),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${states["deaths"]}",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                                  )),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              )),
            ),
          );
  }
}
