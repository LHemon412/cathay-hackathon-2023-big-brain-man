import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;


Future<Passenger> fromPassengerId(String pid) async {
  final res = await http.get(
      Uri.https('developers.cathaypacific.com', 'hackathon-apigw/airport/customers/$pid/details'),
      headers: {
        'apiKey': '0Ws2MAmAseTl39JZLohswZZgWLCxpZ1K',
        'Access-Control-Allow-Origin': "*",
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
  );
  if (res.statusCode == 200) {
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final traveler = json['data']['traveler'];
    Passenger member = Passenger(
      pid,
      traveler['name']['firstName'],
      traveler['name']['lastName'],
      traveler['name']['prefix']
    );
    return member;
  } else {
    throw Exception('Failed to fetch passenger details.');
  }
}

class Passenger {
  String pid;
  String firstName;
  String lastName;
  String prefix;
  int creditTier = 2;

  Passenger(
      this.pid,
      this.firstName,
      this.lastName,
      this.prefix
  );
}