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
  TextEditingController c1c = TextEditingController();
  TextEditingController c2c = TextEditingController();
  TextEditingController c3c = TextEditingController();
  TextEditingController c4c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Card.outlined(
          shadowColor: Colors.black,
          elevation: 3,

          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(20),
          //     border: Border.all(color: Colors.black45)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SingleChildScrollView(
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
                          decoration: InputDecoration(
                              hintText: 'Select Size',
                              labelText: 'Select Size',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black45,
                              ),
                              // errorStyle: TextStyle(fontSize: 18.0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)))),
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
                  const SizedBox(
                    height: 50,
                  ),
                  DataTable(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      columns: [
                        DataColumn(
                            label: Text(
                          "Column",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Width",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text("column1")),
                          DataCell(Container(width: 67,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: c1c,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                            ),
                          ))
                        ]),
                        DataRow(cells: [
                          DataCell(Text("column2")),
                          DataCell(Container(width: 67,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: c2c,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                            ),
                          ))
                        ]),
                        DataRow(cells: [
                          DataCell(Text("column3")),
                          DataCell(Container(width: 67,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: c3c,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                            ),
                          ))
                        ]),
                        DataRow(cells: [
                          DataCell(Text("column4")),
                          DataCell(Container(
                            width: 67,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: TextFormField(
                              controller: c4c,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                              ),
                            ),
                          ))
                        ]),
                      ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: ipc,
                          decoration: InputDecoration(
                            labelText: 'IP',
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
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
                          int c1 = int.parse(c1c.text);
                          int c2 = int.parse(c2c.text);
                          int c3 = int.parse(c3c.text);
                          int c4 = int.parse(c4c.text);
                          print("c1==$c1");
                          NetworkPrinter nt = NetworkPrinter();
                          nt.printOne2(ipc.text.toString(),
                              selectedSize.toString(), c1, c2, c3, c4, context);
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
    );
  }
}
