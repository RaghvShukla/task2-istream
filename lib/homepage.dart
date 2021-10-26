import 'package:flutter/material.dart';
import 'package:t2p/login_page.dart';
import 'api.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<ApiData> futureApiData;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Jake's Git"),
          actions: [
            IconButton(onPressed: (){logOut(context);}, icon: Icon(Icons.login_outlined))
          ],
        ),
        body: FutureBuilder<List<dynamic>>(
          future: getData(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      isThreeLine: true,
                      leading: Icon(Icons.book, size: 60),
                      title: Text(snapshots.data![index]['name'],
                          style: TextStyle(fontSize: 18)),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshots.data![index]['description']),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Icon(Icons.code),
                              Text(snapshots.data![index]['language'],
                                  style: TextStyle(fontSize: 14)),
                              SizedBox(width: 15),
                              Icon(Icons.bug_report),
                              Text(
                                  snapshots.data![index]['open_issues']
                                      .toString(),
                                  style: TextStyle(fontSize: 14)),
                              SizedBox(width: 15),
                              Icon(Icons.face),
                              Text(
                                  snapshots.data![index]['watchers_count']
                                      .toString(),
                                  style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    );
                  });
            }
            if (snapshots.hasError) {
              return Center(child: const Text('Oops, something went wrong'));
            }
            if (snapshots.connectionState == ConnectionState.done) {
              return const Text("connecting");
            }
            return const Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                ),
              ),
            );
          },
        ));
  }
}
