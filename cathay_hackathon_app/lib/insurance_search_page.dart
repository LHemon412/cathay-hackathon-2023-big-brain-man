import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'member.dart';
import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';


class InsuranceSearchPage extends StatefulWidget {
  InsuranceSearchPage({super.key, required this.passenger});
  Passenger passenger;

  @override
  State<InsuranceSearchPage> createState() => _InsuranceSearchPageState();
}

class _InsuranceSearchPageState extends State<InsuranceSearchPage> {
  LatLng? selAirportLoc;
  String? selTripNature;
  double numOfPeople = 1;
  bool showResult = false;
  final mapController = MapController();

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color.fromRGBO(191, 179, 157, 1);
    Passenger psg = widget.passenger;
    if (showResult) {
      return const Column(
        children: [
          Text(
            "Suggested Insurance Plans",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          Card(
            child: Column(
              children: [
                Image(
                    height: 200,
                    image: AssetImage('assets/insurance1.jpg')
                )
              ]
            )
          )
        ]
      );
    } else {
      return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('airports.json'),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final json = jsonDecode(snapshot.data!) as List<dynamic>;
            List<DropdownMenuItem<LatLng>> airportList = [];
            for (int i = 0; i < 25; i++) {
              dynamic obj = json[i];
              airportList.add(DropdownMenuItem<LatLng>(
                value: LatLng(obj['_geoloc']['lat'], obj['_geoloc']['lng']),
                child: Text(
                    "${obj['city']} - ${obj['name']}"
                ),
              ));
            }
            return Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Tailor-made Insurance Plan",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    Container(
                      height: 600,
                      width: double.infinity,
                      child: Card(
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        DropdownButton2<LatLng>(
                                          isExpanded: true,
                                          hint: const Text('Airport'),
                                          items: airportList,
                                          value: selAirportLoc,
                                          onChanged: (LatLng? value) {
                                            setState(() {
                                              selAirportLoc = value;
                                            });
                                            if (value != null) {
                                              mapController.move(value, 9.2);
                                            }
                                          },
                                          buttonStyleData: const ButtonStyleData(
                                            padding: EdgeInsets.symmetric(horizontal: 16),
                                            height: 40,
                                            width: 350,
                                          ),
                                          menuItemStyleData: const MenuItemStyleData(height: 40),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 300,
                                          child: FlutterMap(
                                            mapController: mapController,
                                            options: const MapOptions(
                                              initialCenter: LatLng(0,0),
                                              initialZoom: 9.2,
                                            ),
                                            children: [
                                              TileLayer(
                                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                userAgentPackageName: 'com.github.lhemon412',
                                              ),
                                            ]
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      children: [
                                        const Text("Trip Nature"),
                                        const SizedBox(width: 32),
                                        DropdownButton2<String>(
                                          isExpanded: true,
                                          items: ['Travel', 'Work'].map((String lbl) => DropdownMenuItem<String>(
                                            value: lbl,
                                            child: Text(lbl),
                                          )).toList(),
                                          value: selTripNature,
                                          onChanged: (String? value) {
                                            setState(() {
                                              selTripNature = value;
                                            });
                                          },
                                          buttonStyleData: const ButtonStyleData(
                                            padding: EdgeInsets.symmetric(horizontal: 16),
                                            height: 40,
                                            width: 150,
                                          ),
                                          menuItemStyleData: const MenuItemStyleData(height: 40),
                                        )
                                      ]
                                    ),
                                    Row(
                                      children: [
                                        const Text('Number of People'),
                                        const SizedBox(width: 32),
                                        Text(numOfPeople.round().toString()),
                                        Slider(
                                          value: numOfPeople,
                                          max: 30,
                                          divisions: 30,
                                          label: numOfPeople.round().toString(),
                                          onChanged: (double value) {
                                            setState(() {
                                              numOfPeople = value;
                                            });
                                          }
                                        )
                                      ]
                                    ),
                                    const Text("Other concerns:"),
                                    Container(
                                      width: 250,
                                      height: 120,
                                      child: const TextField(
                                        keyboardType: TextInputType.multiline,
                                        minLines: 3,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder()
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          style: ButtonStyle(
                                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                            backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
                                          ),
                                          child: const Text('Search'),
                                          onPressed: () {
                                            setState(() {
                                              showResult = true;
                                            });
                                          }
                                        )
                                      ]
                                    )
                                  ]
                              )
                          )
                      ),
                    ),
                  ]
              ),
            );
          }
          return const CircularProgressIndicator();
        }
      );
    }
  }
}