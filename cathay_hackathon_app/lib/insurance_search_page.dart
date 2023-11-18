import 'package:flutter/material.dart';
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
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Suggested Insurance Plans",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
              SizedBox(
                width: 400,
                child: Card(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.0),
                              child: const Image(
                                  height: 200,
                                  image: AssetImage('assets/insurance1.jpg'),
                                  fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              left: 10,
                              top: 10,
                              child: TextButton(
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                ),
                                child: const Text("Select"),
                                onPressed: () {},
                              ),
                            )
                          ]
                        ),
                        const SizedBox(height: 8),
                        const Text("Flying Bird Company", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                        const Text("Health, luggage and robbery insurance claim included."),
                        const Text("Package: 1280 HKD"),
                      ]
                    ),
                  )
                ),
              ),
              SizedBox(
                width: 400,
                child: Card(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: const Image(
                                      height: 200,
                                      image: AssetImage('assets/insurance2.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    top: 10,
                                    child: TextButton(
                                      style: ButtonStyle(
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      ),
                                      child: const Text("Select"),
                                      onPressed: () {},
                                    ),
                                  )
                                ]
                            ),
                            SizedBox(height: 8),
                            Text("Staysafe Company", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                            Text("An all-rounded package."),
                            Text("Package: 1780 HKD"),
                          ]
                      ),
                    )
                ),
              )
            ]
          ),
        ),
      );
    } else {
      return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/airports.json'),
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
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: SingleChildScrollView(
                child: Column (
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Tailor-made Insurance Plan",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                      ),
                      Container(
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
                                                mapController.move(value, 11);
                                              }
                                            },
                                            buttonStyleData: const ButtonStyleData(
                                              padding: EdgeInsets.symmetric(horizontal: 16),
                                              height: 40,
                                              width: 280,
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
                                            width: 250,
                                            child: FlutterMap(
                                              mapController: mapController,
                                              options: const MapOptions(
                                                initialCenter: LatLng(0,0),
                                                initialZoom: 11,
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
                                              width: 120,
                                            ),
                                            menuItemStyleData: const MenuItemStyleData(height: 40),
                                          )
                                        ]
                                      ),
                                      const Text('Number of People'),
                                      Row(
                                        children: [
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
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        }
      );
    }
  }
}