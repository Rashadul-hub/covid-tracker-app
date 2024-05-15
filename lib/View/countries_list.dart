import 'package:covid_tracker_app/AppStrings.dart';
import 'package:covid_tracker_app/Model/countries_list_model.dart';
import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/View/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen>
    with TickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();

  //Controller For Rotating the Loading Screen
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: AppStrings.hintSearchBarText,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0))),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.countriesListApi(),
                builder: (context,
                    AsyncSnapshot<List<CountriesListModel>> snapshot) {

                  if (!snapshot.hasData) {
                    
                    return
                      Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.cyan,
                            size: 50.0,
                            controller: _controller,
                          ));
                  } else {
                    return ListView.builder(
                        itemCount: statesServices.countryList.length,
                        itemBuilder: (context, index) {
                          // String name = snapshot.data![index].country ;
                          String name = snapshot.data![index].country.toString();

                          if(searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => DetailScreen(

                                          image: snapshot.data![index].countryInfo!.flag.toString(),
                                          name: snapshot.data![index].country.toString(),
                                          population:int.parse(snapshot.data![index].population.toString()) ,
                                          totalCases:  int.parse(snapshot.data![index].cases.toString()),
                                          totalRecovered:  int.parse(snapshot.data![index].recovered.toString()),
                                          totalDeaths:  int.parse(snapshot.data![index].deaths.toString()),
                                          active:  int.parse(snapshot.data![index].active.toString()),
                                          test:  int.parse(snapshot.data![index].tests.toString()),
                                          todayRecovery:  int.parse(snapshot.data![index].todayRecovered.toString()),
                                          critical:  int.parse(snapshot.data![index].critical.toString()),


                                        )));
                                  },
                                  child: ListTile(
                                    title: Text(
                                        snapshot.data![index].country.toString()),
                                    subtitle: Text(
                                        'Total Cases: ${snapshot.data![index].cases}'),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot
                                          .data![index].countryInfo!.flag
                                          .toString()),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else if (name.toLowerCase().contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => DetailScreen(

                                          image: snapshot.data![index].countryInfo!.flag.toString(),
                                          name: snapshot.data![index].country.toString(),
                                          population:int.parse(snapshot.data![index].population.toString()) ,
                                          totalCases:  int.parse(snapshot.data![index].cases.toString()),
                                          totalRecovered:  int.parse(snapshot.data![index].recovered.toString()),
                                          totalDeaths:  int.parse(snapshot.data![index].deaths.toString()),
                                          active:  int.parse(snapshot.data![index].active.toString()),
                                          test:  int.parse(snapshot.data![index].tests.toString()),
                                          todayRecovery:  int.parse(snapshot.data![index].todayRecovered.toString()),
                                          critical:  int.parse(snapshot.data![index].critical.toString()),


                                        )));
                                  },
                                  child: ListTile(
                                    title: Text(
                                        snapshot.data![index].country.toString()),
                                    subtitle: Text(
                                        'Total Cases: ${snapshot.data![index].cases}'),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot
                                          .data![index].countryInfo!.flag
                                          .toString()),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                           return Container();
                          }
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
