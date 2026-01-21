import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/Providers/providers.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String dayName = DateFormat('EEEE').format(DateTime.now());
  String time = DateFormat('h:mm a').format(DateTime.now());
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Consumer<Listprovider>(
        builder: (context, model, child) {
          if (model.alllist.isEmpty) {
            return const Center(child: Text('No works to do are added yet'));
          }

          final todo = model.alllist.first;
          final filteredindex = model.filteredIndexes;

          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  spacing: 30,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                      ),
                      onPressed: () {
                        model.setfilter(0);
                      },
                      child: Text("All"),
                    ),
                    SizedBox(width: 320),

                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.green,
                        ),
                      ),
                      onPressed: () {
                        model.setfilter(1);
                      },
                      child: Text("Completed"),
                    ),
                    SizedBox(width: 320),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.redAccent,
                        ),
                      ),
                      onPressed: () {
                        model.setfilter(2);
                      },
                      child: Text("Pending"),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: SingleChildScrollView(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dayName,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              date,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 12),

                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filteredindex.length,
                              itemBuilder: (context, i) {
                                final realIndex = filteredindex[i];
                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          todo.title[realIndex],
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        time,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            todo.isdone[realIndex] =
                                                !todo.isdone[realIndex];
                                          });
                                        },
                                        child: Icon(
                                          todo.isdone[realIndex]
                                              ? Icons.check_box
                                              : Icons.check_box_outline_blank,
                                          color: Colors.white,
                                        ),
                                      ),

                                      const SizedBox(width: 10),

                                      TextButton(
                                        onPressed: () {
                                          // Call the removeTodo method from provider
                                          model.removeTodo(realIndex);
                                        },
                                        child: const Icon(Icons.delete),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
