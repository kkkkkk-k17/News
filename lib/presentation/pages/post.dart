
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:three_pam/presentation/pages/news.dart';

import '../../domain/Welcome.dart';

class PostRoute extends StatefulWidget {
  final Welcome data;

  const PostRoute({Key? key, required this.data}) : super(key: key);

  @override
  State<PostRoute> createState() => PostRouteState();
}

class PostRouteState extends State<PostRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            Center(
            child: Container(
                margin: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SecondRoute()),
                            ),
                        child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Image.asset(
                              'assets/images/back.png',
                              width: 20,
                            ))),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(widget.data.image,
                          width: 360, height: 252, fit: BoxFit.cover),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: Text(
                        widget.data.title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(9, 16, 29, 1)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(255, 104, 97, 1)),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(
                                    16) //                 <--- border radius here
                                ),
                          ),
                          child: Text(
                            widget.data.category.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color.fromRGBO(255, 104, 97, 1)),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/watch.png',
                              width: 15,
                            ),
                            Text(
                                NumberFormat.compact()
                                    .format(widget.data.viewsCount),
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(44, 58, 75, 1)))
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/vector.png',
                              width: 15,
                            ),
                            Text(
                                NumberFormat.compact()
                                    .format(widget.data.viewsCount),
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(44, 58, 75, 1)))
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/Subtract.png',
                              width: 15,
                            ),
                            Text(
                                NumberFormat.compact()
                                    .format(widget.data.viewsCount),
                                style: const TextStyle(
                                    fontSize: 10,
                                    color: Color.fromRGBO(44, 58, 75, 1)))
                          ],
                        )
                      ],
                    ),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                      widget.data.author.avatar,
                                      width: 32,
                                      height: 32,
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                child: Text(
                                  widget.data.author.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Color.fromRGBO(44, 58, 75, 1)),
                                ),
                              )
                            ]),
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                              width: 85,
                              height: 35,
                              padding:
                                  const EdgeInsets.fromLTRB(16, 10, 16, 10),
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 104, 97, 1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                              ),
                              child: const Text(
                                '+ Follow',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                              ),
                            )
                          ],
                        )),
                    Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                        child: Text(widget.data.description)),
                    Text(widget.data.content),
                    Expanded(
                        child: ListView.builder(
                            itemCount: widget.data.tags.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Row(children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 2, 8, 2),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            255, 104, 97, 1)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            16) //                 <--- border radius here
                                        ),
                                  ),
                                  child: Text(
                                    "#${widget.data.tags[index]}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Color.fromRGBO(255, 104, 97, 1)),
                                  ),
                                )
                              ]);
                            }))
                  ],
                ))));
  }
}
