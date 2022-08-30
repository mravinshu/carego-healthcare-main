import 'package:flutter/material.dart';

class BookService extends StatefulWidget {
  const BookService({Key? key}) : super(key: key);

  @override
  State<BookService> createState() => BookServiceState();
}

class BookServiceState extends State<BookService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Book Service"),
      ),
    );
  }
}
