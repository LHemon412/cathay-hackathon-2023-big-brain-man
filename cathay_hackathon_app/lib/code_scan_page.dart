import 'dart:io';

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
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color.fromRGBO(191, 179, 157, 1);
    Passenger psg = widget.passenger;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
      child: Column (
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: SizedBox(
                height: 600,
                width: 300,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: (QRViewController controller) {
                    this.controller = controller;
                    controller.scannedDataStream.listen((scanData) {
                      setState(() {
                        result = scanData;
                      });
                      Future.delayed(const Duration(seconds: 3), () {
                        widget.callback('flight');
                      });
                    });
                    },
                ),
              ),
            ),
            const SizedBox(height: 32),
            Center(
                child: Text(
                    (result == null) ? "Scan QR Code" : "Gate Check-in Finished!"
                )
              )
          ]
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}