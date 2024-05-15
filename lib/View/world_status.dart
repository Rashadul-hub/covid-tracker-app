import 'package:covid_tracker_app/AppStrings.dart';
import 'package:covid_tracker_app/Model/world_states_model.dart';
import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/View/countries_list.dart';
import 'package:covid_tracker_app/View/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatesScreen extends StatefulWidget {
  const WorldStatesScreen({super.key});

  @override
  State<WorldStatesScreen> createState() => _WorldStatesScreenState();
}

class _WorldStatesScreenState extends State<WorldStatesScreen>
    with TickerProviderStateMixin {
  //Controller For Rotating the Loading Screen
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 5), vsync: this)
        ..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  //Colors Pie Chart
  final colorList = <Color>[
    const Color(0xbd588cec),
    const Color(0xff8bf584),
    const Color(0xffff0059),
    const Color(0xfff14bec),
    const Color(0xdf81f1f1),
  ];

  @override
  Widget build(BuildContext context) {
    // API Class
    StatesServices statesServices = StatesServices();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "World Covid Status",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              Expanded(
                child: FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.black87,
                            size: 50.0,
                            controller: _controller,
                          ));
                    } else {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            PieChart(
                              dataMap: {
                                AppStrings.totalPieChartText: double.parse(
                                    snapshot.data!.cases.toString()),
                                AppStrings.recoverPieChartText: double.parse(
                                    snapshot.data!.recovered.toString()),
                                AppStrings.deathPieChartText: double.parse(
                                    snapshot.data!.deaths.toString()),
                                AppStrings.populationText: double.parse(
                                    snapshot.data!.population.toString()),
                                AppStrings.testsText: double.parse(
                                    snapshot.data!.population.toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true),
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                              legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                              animationDuration:
                                  const Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .06),
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.5, // Set a fixed height for the Card

                                child: Card(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ReusableRow(
                                            title: 'Update',
                                            value: snapshot.data!.updated
                                                .toString()),
                                        ReusableRow(
                                            title: 'Population',
                                            value: snapshot.data!.population
                                                .toString()),
                                        ReusableRow(
                                            title: 'Total cases',
                                            value: snapshot.data!.cases
                                                .toString()),
                                        ReusableRow(
                                            title: 'Affected Countries',
                                            value: snapshot
                                                .data!.affectedCountries
                                                .toString()),
                                        ReusableRow(
                                            title: 'Deaths',
                                            value: snapshot.data!.deaths
                                                .toString()),
                                        ReusableRow(
                                            title: 'Recovered',
                                            value: snapshot.data!.recovered
                                                .toString()),
                                        ReusableRow(
                                            title: 'Active',
                                            value: snapshot.data!.active
                                                .toString()),
                                        ReusableRow(
                                            title: 'Critical',
                                            value: snapshot.data!.critical
                                                .toString()),
                                        ReusableRow(
                                            title: 'Today Deaths',
                                            value: snapshot.data!.todayDeaths
                                                .toString()),
                                        ReusableRow(
                                            title: 'Today Recovered',
                                            value: snapshot.data!.todayRecovered
                                                .toString()),
                                        ReusableRow(
                                            title: 'Critical Per One Million',
                                            value: snapshot
                                                .data!.criticalPerOneMillion
                                                .toString()),
                                        ReusableRow(
                                            title: 'Recovered Per One Million',
                                            value: snapshot
                                                .data!.recoveredPerOneMillion
                                                .toString()),
                                        ReusableRow(
                                            title: 'Active Per One Million',
                                            value: snapshot
                                                .data!.activePerOneMillion
                                                .toString()),
                                        ReusableRow(
                                            title: 'Today Recovered',
                                            value: snapshot.data!.todayRecovered
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CountriesListScreen()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.cyan,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Center(
                                  child: Text(
                                    AppStrings.trackCountryButtonText,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                         letterSpacing: 5,
                                         color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
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
          Divider()
        ],
      ),
    );
  }
}
