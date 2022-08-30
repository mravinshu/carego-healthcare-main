import 'package:flutter/material.dart';
import 'color.dart';

TextStyle Heading() =>
    const TextStyle(fontSize: 20, fontFamily: "Roboto", color: Colors.blue);

TextStyle Drawer_Text() =>
    const TextStyle(fontSize: 15, fontFamily: "Roboto", color: Colors.black);

TextStyle Drawer_Text_Selected() =>
    TextStyle(color: service_icon, fontWeight: FontWeight.bold);
