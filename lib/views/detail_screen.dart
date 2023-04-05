import 'package:covid_app/views/world_states.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name, image;
  int totalCases, todayRecovered, totalDeaths, active, recovered, critical;
  late int totalRecoverd;
  DetailScreen(
      {required this.name,
      required this.image,
      required this.totalCases,
      required this.todayRecovered,
      required this.totalDeaths,
      required this.active,
      required this.critical,
      required this.recovered});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.267),
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      ReusableRow(
                          title: "Cases", value: widget.totalCases.toString()),
                      ReusableRow(
                          title: "Recovered",
                          value: widget.recovered.toString()),
                      ReusableRow(
                          title: "todayRecovered",
                          value: widget.todayRecovered.toString()),
                      ReusableRow(
                          title: "Deaths",
                          value: widget.totalDeaths.toString()),
                      ReusableRow(
                          title: "Critical", value: widget.critical.toString()),
                      SizedBox(
                        height: 5,
                      ),
                      ReusableRow(
                          title: "Active", value: widget.active.toString()),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image.toString()),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
