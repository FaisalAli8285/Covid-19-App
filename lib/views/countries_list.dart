import 'package:covid_app/views/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import '../services/states_services.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  StatesServices stateService = StatesServices();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 30),
                    hintText: "search with country name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: stateService.countriesListApi(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.black,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 89,
                                  color: Colors.black,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100);
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]["country"];
                      if (searchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                      name: snapshot.data![index]["country"],
                                      image: snapshot.data![index]
                                          ["countryInfo"]["flag"],
                                      totalCases: snapshot.data![index]
                                          ["cases"],
                                      todayRecovered: snapshot.data![index]
                                          ["todayRecovered"],
                                      totalDeaths: snapshot.data![index]
                                          ["deaths"],
                                      active: snapshot.data![index]["active"],
                                      critical: snapshot.data![index]
                                          ["critical"],
                                      recovered: snapshot.data![index]
                                          ["recovered"],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]["country"]),
                                subtitle: Text(
                                    snapshot.data![index]["cases"].toString()),
                                leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ["countryInfo"]["flag"])),
                              ),
                            )
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                        name: snapshot.data![index]["country"],
                                        image: snapshot.data![index]
                                            ["countryInfo"]["flag"],
                                        totalCases: snapshot.data![index]
                                            ["cases"],
                                        todayRecovered: snapshot.data![index]
                                            ["todayRecovered"],
                                        totalDeaths: snapshot.data![index]
                                            ["deaths"],
                                        active: snapshot.data![index]["active"],
                                        critical: snapshot.data![index]
                                            ["critical"],
                                        recovered: snapshot.data![index]
                                            ["recovered"],
                                      ),
                                    ),);
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]["country"]),
                                subtitle: Text(
                                    snapshot.data![index]["cases"].toString()),
                                leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ["countryInfo"]["flag"])),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
