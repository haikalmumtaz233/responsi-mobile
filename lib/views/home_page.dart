import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsi_tpm/components/hover.dart';
import 'package:responsi_tpm/views/agents_page.dart';
import 'package:responsi_tpm/views/login_page.dart';
import 'package:responsi_tpm/views/maps_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> contents = [
    {
      'name': 'Agents',
      'icon': Icons.person,
      'color': Colors.white,
      'link': const AgentsPage(),
    },
    {
      'name': 'Maps',
      'icon': Icons.map,
      'color': Colors.white,
      'link': const MapsPage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Main Page',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              icon: new Icon(Icons.logout),
              color: Colors.white),
        ],
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        // Center the entire content vertically and horizontally
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: contents
                .map(
                  (data) => Hover(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => data['link']));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width *
                          0.8, // Adjust the width as needed
                      height: MediaQuery.of(context).size.width / 3,
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.transparent.withOpacity(0.5),
                            blurRadius: 8,
                            offset: const Offset(0, 1),
                          )
                        ],
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              data['icon'],
                              size: 32,
                              color: data['color'],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              data['name'],
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
