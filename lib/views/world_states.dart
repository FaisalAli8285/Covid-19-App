import 'package:covid_app/services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../model/world_state_model.dart';
import 'countries_list.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({Key? key}) : super(key: key);

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa268),
    const Color(0xffde5246),
  ];

  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  Widget build(BuildContext context) {
    StatesServices stateService = StatesServices();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          FutureBuilder(
            future: stateService.fetchWorldStateRecords(),
            builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                      color: Colors.black,
                      size: 50.0,
                      controller: _controller,
                    ));
              } else {
                return Column(
                  children: [
                    PieChart(
                      dataMap: {
                        "Total": double.parse(snapshot.data!.cases!.toString()),
                        "Recovered":
                            double.parse(snapshot.data!.recovered!.toString()),
                        "Deaths":
                            double.parse(snapshot.data!.deaths!.toString()),
                      },
                      legendOptions: LegendOptions(
                        legendPosition: LegendPosition.left,
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true,
                      ),
                      chartType: ChartType.ring,
                      chartRadius: MediaQuery.of(context).size.width / 2.5,
                      colorList: colorList,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: Card(
                        child: Column(
                          children: [
                            ReusableRow(
                                title: "Total",
                                value: snapshot.data!.cases!.toString()),
                            ReusableRow(
                                title: "Death",
                                value: snapshot.data!.deaths!.toString()),
                            ReusableRow(
                                title: "Recovered",
                                value: snapshot.data!.recovered!.toString()),
                            ReusableRow(
                                title: "Active",
                                value: snapshot.data!.active!.toString()),
                            ReusableRow(
                                title: "Critical",
                                value: snapshot.data!.critical!.toString()),
                            ReusableRow(
                                title: "Today Cases",
                                value: snapshot.data!.todayCases!.toString()),
                            ReusableRow(
                                title: "Today Deaths",
                                value: snapshot.data!.todayDeaths!.toString()),
                            ReusableRow(
                                title: "Today Recovered",
                                value:
                                    snapshot.data!.todayRecovered!.toString()),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CountriesList(),
                              ));
                        },
                        child: Center(
                          child: Text("Track Countries"),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      )),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(),
        ],
      ),
    );
  }
}
