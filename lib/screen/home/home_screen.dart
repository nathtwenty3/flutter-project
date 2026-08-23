import 'package:flutter/material.dart';
import 'package:pro_23/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        backgroundColor: primaryColor,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: primaryColor),
              accountName: Text("Neng Phanath"),
              accountEmail: Text(
                "nath@example.com",
                style: TextStyle(color: Colors.white70),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "AD",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(leading: Icon(Icons.person_outline), title: Text('Users')),
            ListTile(
              leading: Icon(Icons.person_add_alt_outlined),
              title: Text('New user'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.translate),
              title: Text('Language'),
              trailing: Text(
                'English',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.signal_cellular_alt),
              title: Text('Connection'),
              trailing: Text(
                'Online',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text('Logout', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Welcome to the Home Screen!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
