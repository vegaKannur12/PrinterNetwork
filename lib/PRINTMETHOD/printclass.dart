import 'dart:typed_data';
import 'dart:ui';

import 'package:esc/Snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:flutter_esc_pos_network/flutter_esc_pos_network.dart';
import 'package:image/image.dart' as img;

class NetworkPrinter {
  printOne1() async {
    // final printer = PrinterNetworkManager('192.168.18.100');
    // PosPrintResult connect = await printer.connect();
    print("heloo test");
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    List<int> bytes = [];

    bytes += generator.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    bytes += generator.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: const PosStyles(codeTable: 'CP1252'));
    bytes += generator.text('Special 2: blåbærgrød',
        styles: const PosStyles(codeTable: 'CP1252'));

    bytes += generator.text('Bold text', styles: const PosStyles(bold: true));
    bytes +=
        generator.text('Reverse text', styles: const PosStyles(reverse: true));
    bytes += generator.text('Underlined text',
        styles: const PosStyles(underline: true), linesAfter: 1);
    bytes += generator.text('Align left',
        styles: const PosStyles(align: PosAlign.left));
    bytes += generator.text('Align center',
        styles: const PosStyles(align: PosAlign.center));
    bytes += generator.text('Align right',
        styles: const PosStyles(align: PosAlign.right), linesAfter: 1);
    bytes += generator.hr();
    bytes += generator.row([
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col6',
        width: 6,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'col3',
        width: 3,
        styles: const PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    bytes += generator.text('Text size 200%',
        styles: const PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));
    bytes += generator.hr(ch: '_');
    // Print barcode
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData));

    bytes += generator.feed(2);
    bytes += generator.cut();
    await printTest(bytes);
    // return bytes;
  }

  printTest(List<int> ticket) async {
    print("heloo prin");
    final printer = PrinterNetworkManager('192.168.18.245');
    PosPrintResult connect = await printer.connect();
    if (connect == PosPrintResult.success) {
      print("heloo prin 22");
      PosPrintResult printing = await printer.printTicket(ticket);
      print(printing.msg);
      printer.disconnect();
    }
  }

  printOne2(String ip, String papers, BuildContext context) async {
    try {
      print("ip = $ip \npapersiz = $papers");
      print("heloo testvega");
      dynamic generator;
      //to add img
      ByteData imageByteData = await rootBundle.load("assets/logo-vega.png");
      Uint8List imageBytesUint8List = imageByteData.buffer.asUint8List();
      // Image image = decodeImage(imageBytesUint8List)!;
      img.Image image = img.decodeImage(imageBytesUint8List)!;
      print("img---$image");
      final profile = await CapabilityProfile.load();
      if (papers == "80mm") {
        generator = Generator(PaperSize.mm80, profile);
      } else if (papers == "72mm") {
        generator = Generator(PaperSize.mm72, profile);
      } else {
        generator = Generator(PaperSize.mm58, profile);
      }
      List<int> bytes = [];
      bytes += generator.image(image);
      bytes += generator.text('VEGA BUSINESS SOFTWARE',
          styles: const PosStyles(
              align: PosAlign.center, bold: true, height: PosTextSize.size6));
      bytes += generator.text('GLOBAL VILLAGE',
          styles: const PosStyles(
              align: PosAlign.center, bold: true, height: PosTextSize.size3));
      bytes += generator.text('FORT ROAD, KANNUR',
          styles: const PosStyles(
              align: PosAlign.center, bold: true, height: PosTextSize.size3));
      bytes += generator.text('PHONE : 0490-2326271',
          styles: const PosStyles(
              align: PosAlign.center, bold: true, height: PosTextSize.size3));
      bytes += generator.text('GSTIN : XXXXXXXXXXXXX',
          styles: const PosStyles(
              align: PosAlign.center, bold: true, height: PosTextSize.size3));
      bytes += generator.text('TAX INVOICE',
          styles: const PosStyles(
              align: PosAlign.center,
              bold: true,
              height: PosTextSize.size3,
              underline: true));
      bytes += generator.feed(1);
      bytes += generator.row([
        PosColumn(
          text: 'Bill No : ',
          width: 4,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: '157015',
          width: 4,
          styles: const PosStyles(align: PosAlign.left, bold: true),
        ),
        PosColumn(
          text: 'Date : 02-Aug-2024',
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
      bytes += generator.row([
        PosColumn(
          text: 'To',
          width: 3,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: ': Customer Name',
          width: 9,
          styles: const PosStyles(align: PosAlign.left),
        ),
      ]);
      bytes += generator.row([
        PosColumn(
          text: 'Phone',
          width: 3,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: ': Cust Phone No',
          width: 9,
          styles: const PosStyles(align: PosAlign.left),
        ),
      ]);
      bytes += generator.feed(1);
      bytes += generator.row([
        PosColumn(
          text: 'Col1',
          width: 3,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: 'Col2',
          width: 3,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: 'Col3',
          width: 3,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: 'Col4',
          width: 3,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
      bytes += generator.hr(ch: '_');
      bytes += generator.row([
        PosColumn(
          text: '1',
          width: 3,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: 'A1001',
          width: 3,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: '199.75',
          width: 3,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: '799.00',
          width: 3,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
      bytes += generator.row([
        PosColumn(
          text: '2',
          width: 3,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: 'A1002',
          width: 3,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: '375.75',
          width: 3,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: '1500.40',
          width: 3,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
      bytes += generator.row([
        PosColumn(
          text: '3',
          width: 3,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: 'A1003',
          width: 3,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: '400.00',
          width: 3,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: '1603.00',
          width: 3,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
      bytes += generator.hr(ch: '_');
      bytes += generator.row([
        PosColumn(
          text: '975.50',
          width: 9,
          styles: const PosStyles(align: PosAlign.right),
        ),
        PosColumn(
          text: '3902.40',
          width: 3,
          styles: const PosStyles(
              align: PosAlign.right,
              bold: true,
              height: PosTextSize.size3,
              fontType: PosFontType.fontB),
        ),
      ]);
      bytes += generator.hr(ch: '_');
      bytes += generator.feed(1);
      bytes += generator.row([
        PosColumn(
          text: 'Footer 1',
          width: 3,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text: 'xxxxxxxxxxxxxxxxxxxxxxx',
          width: 9,
          styles: const PosStyles(align: PosAlign.left),
        ),
      ]);
      bytes += generator.feed(2);
      bytes += generator.cut();
      await printTest2(bytes, ip, context);
    } catch (e) {
      print("Exception----$e");
      CustomSnackbar snk = CustomSnackbar();
      snk.showSnackbar(context, e.toString(), "");
    }
  }

  printTest2(List<int> ticket, String ipp, BuildContext context) async {
    print("heloo vega--$ipp");
    try {
      final printer = PrinterNetworkManager(ipp);
      PosPrintResult connect = await printer.connect();
      if (connect == PosPrintResult.success) {
        print("heloo vega 22");
        PosPrintResult printing = await printer.printTicket(ticket);
        print(printing.msg);
        printer.disconnect();
        // return true;
      }
      // else if (connect == PosPrintResult.timeout) {
      //   CustomSnackbar snk = CustomSnackbar();
      //   snk.showSnackbar(context, "Connection Timeout...", "");
      // }
      else {
        CustomSnackbar snk = CustomSnackbar();
        snk.showSnackbar(context, "Cant Connect...", "");
      }
    } catch (e) {
      CustomSnackbar snk = CustomSnackbar();
      snk.showSnackbar(context, e.toString(), "");
    }
  }
}
