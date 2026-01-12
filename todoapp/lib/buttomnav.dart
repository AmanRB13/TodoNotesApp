import 'package:flutter/material.dart';
import 'Addtodoworks.dart';
import 'dashboard.dart';
import 'Models/notes_create.dart';
import 'Models/notes_view.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  int selectedindex = 0;
  PageController pageController = PageController();

  void ontappeditem(int index) {
    setState(() {
      selectedindex = index;
    });
    pageController.jumpToPage(selectedindex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('To do List  app'),
        actions: [
          TextButton(onPressed: () {}, child: Icon(Icons.home, size: 20)),
        ],
      ),
      drawer: Drawer(
        child: Container(
          child: ListView(
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://wallpapers.com/images/hd/aesthetic-laptop-drawing-kzs2xmyje63oewbt.jpg',
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'aman',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('amanranabhat30@gmail.com'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              ListTile(
                leading: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                  child: Icon(Icons.home),
                ),
                title: Text('Home'),
              ),

              ListTile(
                leading: ElevatedButton(
                  onPressed: () {},
                  child: Icon(Icons.settings),
                ),
                title: Text('Settings'),
              ),
              ListTile(
                leading: ElevatedButton(
                  onPressed: () {},

                  child: Icon(Icons.details),
                ),
                title: Text('Details'),
              ),
              ListTile(
                leading: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/auth');
                  },
                  child: Icon(Icons.logout),
                ),
                title: Text('Log out'),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [Dashboard(), Addtodowork(), Notes(), NotesView()],
      ),

      bottomNavigationBar: SingleChildScrollView(
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add ToDo Works',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Notes'),
            BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
          ],
          currentIndex: selectedindex,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.blueGrey,
          onTap: ontappeditem,
        ),
      ),
    );
  }
}

