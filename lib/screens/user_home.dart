import 'package:flutter/material.dart';
import 'package:library_app/services/google_signin.dart';
import 'package:library_app/tabs/all_books.dart';
import 'package:library_app/tabs/available_books.dart';
import 'package:library_app/tabs/issued_books.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  AuthService auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () => auth.signOut(context),
                child: Column(
                  children: const [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
            centerTitle: true,
            backgroundColor: Colors.purple[400],
            title: Text('Catalogue of Books'),
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text('Available'),
                ),
                Tab(
                  child: Text('Issued'),
                ),
                Tab(
                  child: Text('All'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              AvailableBooks(),
              IssuedBooks(),
              AllBooks(),
            ],
          ),
        ));
  }
}
