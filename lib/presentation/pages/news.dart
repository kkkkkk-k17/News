import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:three_pam/presentation/pages/post.dart';

import '../../domain/Welcome.dart';

class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  State<SecondRoute> createState() => SecondRouteState();
}

class SecondRouteState extends State<SecondRoute> {
  final baseUrl = 'https://news-app-api.k8s.devebs.net/articles';
  int page = 1;

  final int limit = 5;

  bool isFirstLoadRunning = false;
  bool hasNextPage = true;

  bool isLoadMoreRunning = false;

  Welcomes posts = Welcomes(welcomes: []);
  Welcomes features = Welcomes(welcomes: []);

  void loadMore() async {
    if (hasNextPage == true &&
        isFirstLoadRunning == false &&
        isLoadMoreRunning == false &&
        controller.position.extentAfter < 100) {
      setState(() {
        isLoadMoreRunning = true;
        page += 1; // Display a progress indicator at the bottom
      });
      // Increase page by 1

      try {
        var dio = Dio();
        final res = await dio.get("$baseUrl?page=$page&per_page=$limit");
        final Welcomes fetchedPosts = Welcomes.fromJson(res.data);
        if (res.data['current_page'] == res.data['total_pages']) {
          setState(() {
            hasNextPage = false;
          });
        }
        if (fetchedPosts.welcomes.isNotEmpty) {
          setState(() {
            posts.welcomes.addAll(fetchedPosts.welcomes);
          });
        } else {
          setState(() {
            hasNextPage = false;
          });
        }
      } catch (err) {
        setState(() {
          hasNextPage = false;
        });
        print('Something went wrong!');
      }
      setState(() {
        isLoadMoreRunning = false;
      });
    }
  }

  void firstLoad() async {
    setState(() {
      isFirstLoadRunning = true;
    });
    try {
      var dio = Dio();
      final res = await dio.get("$baseUrl?page=$page&per_page=$limit");
      final Welcomes test = Welcomes.fromJson(res.data);
      setState(() {
        posts = test;
      });
    } catch (err) {
      print(err);
      print('Something went wrong');
    }
    setState(() {
      isFirstLoadRunning = false;
    });
  }

  void featuresLoad() async {
    try {
      var dio = Dio();
      final res = await dio.get("$baseUrl?page=1&is_featured=true");
      final Welcomes test = Welcomes.fromJson(res.data);
      setState(() {
        features = test;
      });
    } catch (err) {
      print(err);
      print('Something went wrong');
    }
  }

  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  // }
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    firstLoad();
    featuresLoad();
    controller = ScrollController()..addListener(loadMore);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isFirstLoadRunning
          ? const Center(child: CircularProgressIndicator())
          : Center(
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
                  SizedBox(
                    height: 250,
                    child: features.welcomes.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: features.welcomes.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        16, 0, 10, 22),
                                    child: Stack(children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: CachedNetworkImage(
                                            imageUrl:
                                                features.welcomes[index].image,
                                            width: 310,
                                            height: 252,
                                            fit: BoxFit.cover),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            12, 0, 12, 24),
                                        width: 280,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              features.welcomes[index].title,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromRGBO(
                                                      255, 255, 255, 1)),
                                            ),
                                            GestureDetector(
                                                onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PostRoute(
                                                                  data: features
                                                                          .welcomes[
                                                                      index])),
                                                    ),
                                                child: Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 8, 0, 0),
                                                  width: 100,
                                                  height: 36,
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 10, 16, 10),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        254, 131, 125, 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(24),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'Read Now',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Color.fromRGBO(
                                                            255, 255, 255, 1)),
                                                  ),
                                                ))
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
                    child: posts.welcomes.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: posts.welcomes.length,
                              controller: controller,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PostRoute(
                                                  data: posts.welcomes[index])),
                                        ),
                                    child: Container(
                                        margin: const EdgeInsets.fromLTRB(
                                            16, 0, 16, 12),
                                        width: 358,
                                        height: 156,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  235, 238, 242, 1)),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(
                                                  16) //                 <--- border radius here
                                              ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                  posts.welcomes[index].image,
                                                  width: 150,
                                                  height: 156,
                                                  fit: BoxFit.cover),
                                            ),
                                            Flexible(
                                                child: Container(
                                                    margin: const EdgeInsets
                                                            .fromLTRB(
                                                        16, 24, 24, 16),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        Text(
                                                          posts.welcomes[index]
                                                              .title,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          44,
                                                                          58,
                                                                          75,
                                                                          1)),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Container(
                                                              margin: const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 4, 0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                child: Image.network(
                                                                    posts
                                                                        .welcomes[
                                                                            index]
                                                                        .author
                                                                        .avatar,
                                                                    width: 16,
                                                                    height: 16,
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets
                                                                      .fromLTRB(
                                                                  0, 0, 10, 0),
                                                              child: Text(
                                                                posts
                                                                    .welcomes[
                                                                        index]
                                                                    .author
                                                                    .name,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            44,
                                                                            58,
                                                                            75,
                                                                            1)),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      8,
                                                                      2,
                                                                      8,
                                                                      2),
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    color: const Color
                                                                            .fromRGBO(
                                                                        255,
                                                                        104,
                                                                        97,
                                                                        1)),
                                                                borderRadius:
                                                                    const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            16) //                 <--- border radius here
                                                                        ),
                                                              ),
                                                              child: Text(
                                                                posts
                                                                    .welcomes[
                                                                        index]
                                                                    .category
                                                                    .title,
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        10,
                                                                    color: Color
                                                                        .fromRGBO(
                                                                            255,
                                                                            104,
                                                                            97,
                                                                            1)),
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
                                                                        .fromLTRB(
                                                                    0, 0, 0, 0),
                                                                child: Image.asset(
                                                                    'assets/images/Vector.png')),
                                                            Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        0,
                                                                        0,
                                                                        18.67,
                                                                        0),
                                                                child: Text(
                                                                    NumberFormat
                                                                            .compact()
                                                                        .format(posts
                                                                            .welcomes[
                                                                                index]
                                                                            .viewsCount)
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Color.fromRGBO(
                                                                            44,
                                                                            58,
                                                                            75,
                                                                            1)))),
                                                            Container(
                                                                margin: const EdgeInsets
                                                                        .fromLTRB(
                                                                    0, 0, 0, 0),
                                                                child: Image.asset(
                                                                    'assets/images/Subtract.png')),
                                                            Container(
                                                                margin: const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    0,
                                                                    40,
                                                                    0),
                                                                child: Text(
                                                                    NumberFormat
                                                                            .compact()
                                                                        .format(posts
                                                                            .welcomes[
                                                                                index]
                                                                            .viewsCount)
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Color.fromRGBO(
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
                                        )));
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
