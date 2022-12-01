import 'package:flutter/material.dart';

import 'helper/API_helper.dart';
import 'model/user.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List userPageList = [1, 2];
  dynamic initialPage = "1";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("User"),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "User Details",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                DropdownButton(
                    value: initialPage,
                    items: userPageList
                        .map(
                          (e) => DropdownMenuItem(
                            value: "$e",
                            child: Text("Page - $e"),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        initialPage = val;
                      });
                    }),
              ],
            ),
            FutureBuilder(
              future: APIhelper.getUserList(page: initialPage.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<User>? allUserList = snapshot.data;
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                          columns: const [
                            DataColumn(
                              label: Text("ID"),
                            ),
                            DataColumn(label: Text("IMAGE")),
                            DataColumn(
                              label: Text("First Name"),
                            ),
                            DataColumn(
                              label: Text("Last Name"),
                            ),
                            DataColumn(
                              label: Text("Email"),
                            ),
                          ],
                          rows: allUserList!
                              .map(
                                (e) => DataRow(
                                  cells: [
                                    DataCell(Text("${e.id}")),
                                    DataCell(
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(e.image),
                                      ),
                                    ),
                                    DataCell(Text(e.firstName)),
                                    DataCell(Text(e.lastName)),
                                    DataCell(Text(e.email)),
                                  ],
                                ),
                              )
                              .toList()),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text("${snapshot.error}"),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
