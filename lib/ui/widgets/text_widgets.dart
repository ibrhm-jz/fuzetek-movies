import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget titleText(String text) {
  return Text(
    text,
    style: const TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
  );
}

Widget subtitleText(String text) {
  return Expanded(
    child: Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      overflow: TextOverflow.clip,
    ),
  );
}

Widget normalText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 16,
    ),
    overflow: TextOverflow.clip,
    textAlign: TextAlign.justify,
  );
}
