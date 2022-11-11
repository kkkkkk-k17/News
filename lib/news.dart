import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  State<SecondRoute> createState() => SecondRouteState();
}

class News {
  String cover;
  String title;

  News({required this.cover, required this.title});
}

class SecondRouteState extends State<SecondRoute> {
  List dataList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      dataList = Provider.of(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Display the data loaded from sample.json
            Container(
              margin: const EdgeInsets.fromLTRB(16, 53, 16, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    "Featured",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(44, 58, 75, 1)),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 104, 97, 1)),
                  )
                ],
              ),
            ),
            Container(
              height: 250,
              child: dataList[0].isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: dataList[0].length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.fromLTRB(16, 0, 10, 22),
                              child: Stack(children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: CachedNetworkImage(
                                      imageUrl: dataList[0][index]["cover"],
                                      width: 310,
                                      height: 252,
                                      fit: BoxFit.cover),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(12, 0, 12, 24),
                                  width: 280,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        dataList[0][index]["title"],
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1)),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            0, 8, 0, 0),
                                        width: 100,
                                        height: 36,
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 10, 16, 10),
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromRGBO(254, 131, 125, 1),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(24),
                                          ),
                                        ),
                                        child: const Text(
                                          'Read Now',
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  255, 255, 255, 1)),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ]));
                        },
                      ),
                    )
                  : Container(),
              // ])
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    "News",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(44, 58, 75, 1)),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(255, 104, 97, 1)),
                  )
                ],
              ),
            ),
            Container(
              child: dataList[1].isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: dataList[1].length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                              width: 358,
                              height: 156,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(235, 238, 242, 1)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                        16) //                 <--- border radius here
                                    ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                        dataList[1][index]["cover"],
                                        width: 150,
                                        height: 156,
                                        fit: BoxFit.cover),
                                  ),
                                  Flexible(
                                      child: Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              16, 24, 24, 16),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                dataList[1][index]["title"],
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromRGBO(
                                                        44, 58, 75, 1)),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(0, 0, 4, 0),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Image.network(
                                                          dataList[1][index]
                                                                  ["portal"]
                                                              ["logo"],
                                                          width: 16,
                                                          height: 16,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(0, 0, 16, 0),
                                                    child: Text(
                                                      dataList[1][index]
                                                          ["portal"]["title"],
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                          color: Color.fromRGBO(
                                                              44, 58, 75, 1)),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(8, 2, 8, 2),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color
                                                                  .fromRGBO(
                                                              255, 104, 97, 1)),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  16) //                 <--- border radius here
                                                              ),
                                                    ),
                                                    child: Text(
                                                      dataList[1][index]
                                                          ["category"],
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 10,
                                                          color: Color.fromRGBO(
                                                              255, 104, 97, 1)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(0, 0, 0, 0),
                                                      child: Image.asset(
                                                          'assets/images/Vector.png')),
                                                  Container(
                                                      margin: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 0, 18.67, 0),
                                                      child: Text(
                                                          NumberFormat.compact()
                                                              .format(
                                                                  dataList[1][
                                                                          index]
                                                                      ["likes"])
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          44,
                                                                          58,
                                                                          75,
                                                                          1)))),
                                                  Container(
                                                      margin: const EdgeInsets
                                                          .fromLTRB(0, 0, 0, 0),
                                                      child: Image.asset(
                                                          'assets/images/Subtract.png')),
                                                  Container(
                                                      margin: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 0, 40, 0),
                                                      child: Text(
                                                          NumberFormat.compact()
                                                              .format(dataList[1][
                                                                      index]
                                                                  ["comments"])
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          44,
                                                                          58,
                                                                          75,
                                                                          1)))),
                                                  Image.asset(
                                                      'assets/images/save.png')
                                                ],
                                              )
                                            ],
                                          ))),
                                ],
                              ));
                        },
                      ),
                    )
                  : Container(),
              // ])
            ),
          ],
        ),
      ),
    );
  }
}
