import 'package:flutter/material.dart';
import 'member.dart';

class CreditHomePage extends StatefulWidget {
  CreditHomePage({super.key, required this.passenger, required this.callback});
  Passenger passenger;
  Function(String) callback;

  @override
  State<CreditHomePage> createState() => _CreditHomePageState();
}

class _CreditHomePageState extends State<CreditHomePage> {
  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color.fromRGBO(191, 179, 157, 1);
    Passenger psg = widget.passenger;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
      child: Column (
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Tier ${psg.creditTier}',
                        style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 12.0),
                        child: SizedBox(
                          width: 200,
                          child: LinearProgressIndicator(
                              value: 0.7
                          ),
                        ),
                      ),
                    ),
                    Text(
                        psg.creditTier == 3 ? '' : 'Tier ${psg.creditTier + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                  ]
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: GestureDetector(
                  child: const Card(
                      child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                              children: [
                                Icon(Icons.flight, color: iconColor),
                                SizedBox(width: 32),
                                Text(
                                    "Your Flight",
                                    style: TextStyle(fontSize: 28)
                                )
                              ]
                          )
                      )
                  ),
                  onTap: () {
                    setState(() {
                      widget.callback('flight');
                    });
                  }
              ),
            ),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: GestureDetector(
                  child: const Card(
                      child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Row(
                              children: [
                                Icon(Icons.health_and_safety, color: iconColor),
                                SizedBox(width: 32),
                                Text(
                                    "Insurance",
                                    style: TextStyle(fontSize: 28)
                                )
                              ]
                          )
                      )
                  ),
                  onTap: () {
                    // setState(() {
                    //   widget.screen = 'insurance';
                    // });
                    widget.callback('insurance');
                  }
              ),
            ),
            const SizedBox(
              height: 100,
              width: double.infinity,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.sports_esports, color: iconColor),
                      SizedBox(width: 32),
                      Text(
                          "Safety Game",
                          style: TextStyle(fontSize: 28)
                      )
                    ])
                  ),
              ),
            )
          ]
      ),
    );
  }
}