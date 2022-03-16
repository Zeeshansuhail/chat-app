import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BubbleChat extends StatelessWidget {
  BubbleChat(
    this.message,
    this.username,
    this.isme,
    this.image_Url,
    this.timestamp,
  );
  final String message;
  final String username;
  final bool isme;
  final String image_Url;
  final Timestamp timestamp;
  //final Key key;
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Row(
            mainAxisAlignment:
                isme ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (isme != true)
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(image_Url),
                ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color:
                            isme ? Colors.grey : Theme.of(context).accentColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomLeft:
                              isme ? Radius.circular(40) : Radius.circular(0),
                          bottomRight:
                              isme ? Radius.circular(0) : Radius.circular(40),
                        )),
                    width: 140,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    margin: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: isme
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                              color: isme
                                  ? Colors.black
                                  : Theme.of(context)
                                      .accentTextTheme
                                      .title
                                      .color,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          message,
                          style: TextStyle(
                              color: isme
                                  ? Colors.black
                                  : Theme.of(context)
                                      .accentTextTheme
                                      .title
                                      .color),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
        // if (isme != true)
        //   Positioned(
        //       top: 0,
        //       left: isme ? null : 120,
        //       right: isme ? 120 : null,
        //       child: CircleAvatar(
        //         radius: 22,
        //         backgroundColor: Colors.grey,
        //         backgroundImage: NetworkImage(image_Url),
        //       ))
      ],
    );
  }
}
