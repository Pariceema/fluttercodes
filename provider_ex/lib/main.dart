import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Provider Example',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Name: ${userProvider.user?.name ?? 'N/A'}'),
            Text('Age: ${userProvider.user?.age ?? 'N/A'}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                userProvider.updateUser('Pariceema Macwan', 20);
              },
              child: Text('Update User'),
            ),
          ],
        ),
      ),
    );
  }
}
