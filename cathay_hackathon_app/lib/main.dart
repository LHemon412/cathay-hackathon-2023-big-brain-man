import 'package:cathay_hackathon_app/code_scan_page.dart';
import 'package:cathay_hackathon_app/flight_info_page.dart';
import 'package:cathay_hackathon_app/insurance_search_page.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'insurance_claim_page.dart';
import 'member.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cathay Pacific',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Cathay Pacific'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final String _pid = "510812B00000C8DD";
  Future<Passenger>? _passenger;
  List<String> _screenHistory = ['home'];

  @override
  void initState() {
    super.initState();
    _passenger = fromPassengerId(_pid);
  }

  @override
  Widget build(BuildContext context) {
    const Color iconColor = Color.fromRGBO(191, 179, 157, 1);
    const Color bgColor = Color.fromRGBO(238, 240, 240, 1);
    return Scaffold(
      key: _key,
      resizeToAvoidBottomInset: false,
      endDrawer: Drawer(
        shape: const ContinuousRectangleBorder(),
        child: Container(
          color: bgColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              buildFutureDrawerHeader(),
              const Material(
                child: ListTile(
                  leading: Icon(Icons.person, color: iconColor),
                  tileColor: Colors.white,
                  title: Text("View Profile"),
                  shape: Border(bottom: BorderSide(color: iconColor)),
                ),
              ),
              Material(
                child: ListTile(
                  leading: const Icon(Icons.home, color: iconColor),
                  tileColor: Colors.white,
                  title: const Text("Home"),
                  shape: const Border(bottom: BorderSide(color: iconColor)),
                  onTap: () {
                    setState(() {
                      _screenHistory = ['home'];
                    });
                    _key.currentState!.closeEndDrawer();
                  }
                ),
              ),
              const SizedBox(height: 18),
              const Material(
                child: ListTile(
                  leading: Icon(Icons.flight, color: iconColor),
                  title: Text("Book a trip"),
                  shape: Border(bottom: BorderSide(color: iconColor)),
                ),
              ),
              const Material(
                child: ListTile(
                  leading: Icon(Icons.airplane_ticket, color: iconColor),
                  title: Text("Redeem flights"),
                  shape: Border(bottom: BorderSide(color: iconColor)),
                ),
              ),
              const SizedBox(height: 18),
              const Material(
                child: ListTile(
                  leading: Icon(Icons.manage_search, color: iconColor),
                  title: Text("My Bookings"),
                  shape: Border(bottom: BorderSide(color: iconColor)),
                ),
              ),
              const Material(
                child: ListTile(
                  leading: Icon(Icons.airplane_ticket, color: iconColor),
                  title: Text("Mobile boarding passes"),
                  shape: Border(bottom: BorderSide(color: iconColor)),
                ),
              ),
              const Material(
                child: ListTile(
                  leading: Icon(Icons.schedule, color: iconColor),
                  title: Text("Flight status"),
                  shape: Border(bottom: BorderSide(color: iconColor)),
                ),
              ),
              const Material(
                child: ListTile(
                  leading: Icon(Icons.calendar_month, color: iconColor),
                  title: Text("Timetable"),
                  shape: Border(bottom: BorderSide(color: iconColor)),
                ),
              ),
              const SizedBox(height: 18),
              const Material(
                child: ListTile(
                  leading: Icon(Icons.headphones, color: iconColor),
                  title: Text("Inflight Entertainment"),
                  shape: Border(bottom: BorderSide(color: iconColor)),
                ),
              ),
              const Material(
                child: ListTile(
                  leading: Icon(Icons.settings, color: iconColor),
                  title: Text("Settings"),
                  shape: Border(bottom: BorderSide(color: iconColor)),
                ),
              ),
              Material(
                child: ListTile(
                  leading: const Icon(Icons.logout, color: iconColor),
                  title: Text(_passenger == null ? "Sign in" : "Sign out"),
                  shape: const Border(bottom: BorderSide(color: iconColor)),
                  onTap: () {
                    setState(() {
                      _passenger = fromPassengerId(_pid);
                    });
                  },
                ),
              )
            ]
          ),
        )
      ),
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.notifications),
                          onPressed: () {}
                      ),
                      IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          _key.currentState!.openEndDrawer();
                        },
                      )
                    ]
                ),
                GestureDetector(
                  child: const Center(
                    child: Image(
                      image: AssetImage('assets/cathay_logo.png'),
                      width: 42,
                      height: 42,
                      color: null,
                    ),
                  ),
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                ),
                if (_screenHistory.length > 1)
                  Positioned(
                      child:
                      IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: backScreen
                      )
                  ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: FutureBuilder<Passenger>(
                      future: _passenger,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          switch(_screenHistory.last) {
                            case 'home':
                              return CreditHomePage(passenger: snapshot.data!, callback: changeScreen);
                            case 'insurance':
                              return InsuranceSearchPage(passenger: snapshot.data!);
                            case 'flight':
                              return FlightInfoPage(passenger: snapshot.data!, callback: changeScreen);
                            case 'insurance-claim':
                              return InsuranceClaimPage(passenger: snapshot.data!);
                            case 'code-scan':
                              return CodeScanPage(passenger: snapshot.data!, callback: changeScreen);
                            default:
                              return const Column();
                          }
                        }
                        return const CircularProgressIndicator();
                      }
                    )
                  ),
                ],
              ),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  FutureBuilder<Passenger> buildFutureDrawerHeader() {
    return FutureBuilder<Passenger>(
      future: _passenger,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String prefix = snapshot.data!.prefix;
          String fPrefix = prefix.substring(0, 1) + prefix.substring(1).toLowerCase();
          return DrawerHeader(
            child: Column(
                children: [
                  Text("$fPrefix ${snapshot.data!.lastName}"),
                ]
            ),
          );
        } else if (snapshot.hasError){
          debugPrint('${snapshot.error}');
          return Text('${snapshot.error}');
        }
        return const DrawerHeader(child: Text("Not Logged In"));
      }
    );
  }

  void changeScreen(String screen) {
    setState(() {
      _screenHistory.add(screen);
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void backScreen() {
    setState(() {
      _screenHistory.removeLast();
    });
    FocusManager.instance.primaryFocus?.unfocus();
  }
}