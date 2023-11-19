import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'member.dart';
import 'package:path_provider/path_provider.dart';

class FlightInfoPage extends StatefulWidget {
  const FlightInfoPage({super.key, required this.passenger, required this.callback});
  final Passenger passenger;
  final Function(String) callback;

  @override
  State<FlightInfoPage> createState() => _FlightInfoPageState();
}

class _FlightInfoPageState extends State<FlightInfoPage> {
  DateTime lastUpdated = DateTime.now();
  List<bool> lockedPos = [true, true, true];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column (
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: SizedBox(
                        height: 40,
                        child: Image(image: AssetImage('assets/flight_progress.png')),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.qr_code_scanner),
                      onPressed: () {
                        widget.callback('code-scan');
                      }
                    ),
                  ]
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: lockedPos[0] ? const Icon(Icons.lock) : const Icon(Icons.lock_open),
                              iconSize: 16,
                              onPressed: () {
                                setState(() {
                                  lockedPos[0] = !lockedPos[0];
                                });
                              },
                            ),
                            const Icon(Icons.reorder, size: 16),
                          ]
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Suggested Boarding Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Row(
                              children: [
                                Text('Group 3', style: TextStyle(fontSize: 28)),
                                SizedBox(width: 8),
                                Column(
                                  children: [
                                    Text('GMT+8'),
                                    Text('22:40'),
                                  ]
                                )
                              ],
                            )
                          ]
                        ),
                      ]
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                            children: [
                              IconButton(
                                icon: lockedPos[1] ? const Icon(Icons.lock) : const Icon(Icons.lock_open),
                                iconSize: 16,
                                onPressed: () {
                                  setState(() {
                                    lockedPos[1] = !lockedPos[1];
                                  });
                                },
                              ),
                              const Icon(Icons.reorder, size: 16),
                            ]
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Luggage Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              const SizedBox(height: 8),
                              Table(
                                border: TableBorder.all(color: Colors.transparent),
                                defaultColumnWidth: const IntrinsicColumnWidth(),
                                children: const [
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('ID: 2893DE'),
                                      ),
                                      SizedBox(width: 32),
                                      TableCell(
                                        child: Text('Arrived'),
                                      )
                                    ]
                                  ),
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: Text('Weight: 13kg'),
                                      ),
                                      SizedBox(width: 32),
                                      TableCell(
                                        child: Text('KIX'),
                                      )
                                    ]
                                  )
                                ]
                              ),
                              Text('Last Updated: ${DateFormat('HH:mm:ss').format(lastUpdated)}')
                            ]
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              onPressed: () {
                                setState(() {
                                  lastUpdated = DateTime.now();
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () {
                                widget.callback('insurance-claim');
                              },
                            )
                          ]
                        )
                      ],
                    )
                  )
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                            children: [
                              IconButton(
                                icon: lockedPos[2] ? const Icon(Icons.lock) : const Icon(Icons.lock_open),
                                iconSize: 16,
                                onPressed: () {
                                  setState(() {
                                    lockedPos[2] = !lockedPos[2];
                                  });
                                },
                              ),
                              const Icon(Icons.reorder, size: 16),
                            ]
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Insurance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text('Safeguard Company', style: TextStyle(fontSize: 20)),
                          ]
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () async {
                                final bytes = await rootBundle.load('assets/insurance.pdf');
                                final list = bytes.buffer.asUint8List();
                                final tempDir = await getTemporaryDirectory();
                                final file = await File('${tempDir.path}/insurance.pdf').create();
                                file.writeAsBytesSync(list);
                                Share.shareXFiles([XFile('${tempDir.path}/insurance.pdf')]);
                              },
                            ),
                          ],
                        )
                      ],
                    )
                  )
                ),
                const SizedBox(height: 8),
                const SizedBox(
                  width: double.infinity,
                  child: Image(image: AssetImage('assets/airportDesc1.png'))
                ),
                const SizedBox(height: 8),
                const SizedBox(
                    width: double.infinity,
                    child: Image(image: AssetImage('assets/airportDesc2.png'))
                )
              ]
          ),
        );
  }
}