import 'package:esc/PRINTMETHOD/printclass.dart';
import 'package:flutter/material.dart';

class TEST1 extends StatefulWidget {
  const TEST1({super.key});
  @override
  State<TEST1> createState() => _TEST1State();
}

class _TEST1State extends State<TEST1> {
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  NetworkPrinter nt = NetworkPrinter();
                  nt.printOne1();
                },
                child: Text("TEST1")),        
          ],
        ),
      ),
    );
  }
}