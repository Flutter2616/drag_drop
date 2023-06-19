import 'package:drag_drop/view/drag_screen.dart';
import 'package:flutter/material.dart';

void main() {

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => Dragscreen(),
      },
    ),
  );
}
