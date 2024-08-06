import 'package:esc/PRINTMETHOD/printclass.dart';
import 'package:esc/Snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';

class TEST2 extends StatefulWidget {
  const TEST2({super.key});

  @override
  State<TEST2> createState() => _TEST2State();
}

class _TEST2State extends State<TEST2> {
  List pp = [
    {"size": "80mm", "id": "1"},
    {"size": "58mm", "id": "2"},
    {"size": "72mm", "id": "3"}
  ];
  String selectedSize = "80mm";
  TextEditingController ipc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card.outlined(
            shadowColor: Colors.black,
            elevation: 3,
            child: Container(
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     border: Border.all(color: Colors.black45)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 150,
                          child: Text("Paper Size :"),
                        ),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            hint: Text('Select Size'),
                            value: selectedSize,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSize = newValue!;
                                print("Selected size ----= $selectedSize");
                              });
                            },
                            items: pp.map((item) {
                              return DropdownMenuItem<String>(
                                value: item['size'],
                                child: Text(item['size']),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: ipc,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    ipc.clear();
                                  },
                                  icon: Icon(Icons.close)),
                              hintText: "Type IP here..",
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: () {
                          if (ipc.text == "") {
                            CustomSnackbar snk = CustomSnackbar();
                            snk.showSnackbar(context, "Type IP..", "");
                          } else {
                            NetworkPrinter nt = NetworkPrinter();
                            nt.printOne2(ipc.text.toString(),
                                selectedSize.toString(), context);
                          }

                          // print("ressss----${res.runtimeType}");
                          // if (res == false) {
                          //   print("conected");
                          // } else {
                          //   print("conection failed");
                          // }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "PRINT",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
