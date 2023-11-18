import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'member.dart';

class FlightInfoPage extends StatefulWidget {
  FlightInfoPage({super.key, required this.passenger, required this.callback});
  Passenger passenger;
  Function(String) callback;

  @override
  State<FlightInfoPage> createState() => _FlightInfoPageState();
}

class _FlightInfoPageState extends State<FlightInfoPage> {
  DateTime lastUpdated = DateTime.now();

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color.fromRGBO(191, 179, 157, 1);
    Passenger psg = widget.passenger;
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
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.lock),
                          iconSize: 16,
                          onPressed: () {},
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
                            icon: const Icon(Icons.lock),
                            iconSize: 16,
                            onPressed: () {},
                          ),
                          const Icon(Icons.reorder, size: 16),
                        ]
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Luggage Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          SizedBox(height: 8),
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
                          onPressed: () {},
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
                            icon: const Icon(Icons.lock),
                            iconSize: 16,
                            onPressed: () {},
                          ),
                          const Icon(Icons.reorder, size: 16),
                        ]
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Insurance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Row(
                          children: [
                            const Text('Safeguard Company', style: TextStyle(fontSize: 20)),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: () {
                                widget.callback('insurance-claim');
                              },
                            )
                          ],
                        ),
                      ]
                    ),
                  ],
                )
              )
            )
          ]
      ),
    );
  }
}