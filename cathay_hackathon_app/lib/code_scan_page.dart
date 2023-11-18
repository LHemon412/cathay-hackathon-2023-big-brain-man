import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'member.dart';

class CodeScanPage extends StatefulWidget {
  CodeScanPage({super.key, required this.passenger, required this.callback});
  Passenger passenger;
  Function(String) callback;

  @override
  State<CodeScanPage> createState() => _CodeScanPageState();
}

class _CodeScanPageState extends State<CodeScanPage> {
  final GlobalKey qrKey = GlobalKey();
  Barcode? result;

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color.fromRGBO(191, 179, 157, 1);
    Passenger psg = widget.passenger;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
      child: Column (
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: (QRViewController controller) {
                  controller.scannedDataStream.listen((scanData) {
                    setState(() {
                      result = scanData;
                    });
                    Future.delayed(const Duration(seconds: 3), () {
                      widget.callback('flight');
                    });
                  });
                },
              )
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result != null) ?
                    const Text('Gate Check-in Finished!') :
                    const Text('Scan QR Code')
              )
            )
          ]
      ),
    );
  }
}