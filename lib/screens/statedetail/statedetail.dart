import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:indiacovid19/shared/constants.dart';
import 'package:indiacovid19/shared/loading.dart';

class StateDetail extends StatefulWidget {
  final state;
  const StateDetail({Key key, @required this.state}) : super(key: key);
  @override
  _StateDetailState createState() => _StateDetailState();
}

class _StateDetailState extends State<StateDetail> {
  var api = "https://api.covid19india.org/state_district_wise.json";
  var res, states1, states2;
  List<String> dist = [];
  @override
  fetchData(String st) async {
    res = await http.get(api);
    states1 = jsonDecode(res.body)[st]['districtData'];
    if (this.mounted) {
      setState(() {});
    }
    states1.forEach((k, v) => dist.add(k));
    /*print(dist);*/
  }

  Widget build(BuildContext context) {
    String stateName;
    int j = 1;
    stateName = widget.state["state"];
    fetchData(stateName);
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
                      fetchData(stateName);
                    },
                  )
                ],
              ),
              body: Center(
                  child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "${stateName}",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: states1.length,
                        itemBuilder: (context, index) {
                          var states = states1[dist[index]];
                          if (index == 0) {
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: 150,
                                            height: 150,
                                            child: Card(
                                                shape: cardShape,
                                                child: InkWell(
                                                    splashColor: Colors.blue
                                                        .withAlpha(30),
                                                    //color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
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
                                                                    fontSize:
                                                                        23,
                                                                    color: Colors
                                                                        .red),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                "${widget.state["confirmed"]}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .red,
                                                                    fontSize:
                                                                        20),
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
                                                    splashColor: Colors.blue
                                                        .withAlpha(30),
                                                    //color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
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
                                                                    fontSize:
                                                                        23,
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                "${widget.state["active"]}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blue,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ]),
                                                      ),
                                                    ))),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            width: 150,
                                            height: 150,
                                            child: Card(
                                                shape: cardShape,
                                                child: InkWell(
                                                    splashColor: Colors.blue
                                                        .withAlpha(30),
                                                    //color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Icon(
                                                                  Icons.history,
                                                                  size: 60),
                                                              Text(
                                                                "Recovered",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        23,
                                                                    color: Colors
                                                                        .green),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                "${widget.state["recovered"]}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .green,
                                                                    fontSize:
                                                                        20),
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
                                                    splashColor: Colors.blue
                                                        .withAlpha(30),
                                                    //color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
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
                                                                    fontSize:
                                                                        23,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Text(
                                                                "${widget.state["deaths"]}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20),
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
                                              "Confirmed: +${widget.state["deltaconfirmed"]}",
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
                                              "Recovered: +${widget.state["deltarecovered"]}",
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
                                              "Deaths: +${widget.state["deltadeaths"]}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Last Updated: ${widget.state["lastupdatedtime"]}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8.0, 5, 8, 0),
                                  child: Container(
                                    width: 600,
                                    child: Card(
                                        shape: cardShape,
                                        color: Colors.grey[100],
                                        child: InkWell(
                                          splashColor:
                                              Colors.blue.withAlpha(30),
                                          child: Column(children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Text(
                                                "${dist[index]}",
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
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
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    //spacing: 0,
                                                    children: <Widget>[
                                                      Text("Deaths"),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        "${states["deceased"]}",
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
                                  ),
                                ),
                              ],
                            );
                          } else if (index >= 0) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(8.0, 5, 8, 0),
                              child: Card(
                                  shape: cardShape,
                                  color: Colors.grey[100],
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    child: Column(children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          "${dist[index]}",
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
                                                  "${states["deceased"]}",
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
