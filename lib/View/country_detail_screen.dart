import 'package:covid_tracker_app/View/world_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  String name , image ;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovery, population, test;

   DetailScreen({
     super.key ,
     required this.name,
     required this.critical,
     required this.active,
     required this.image,
     required this.test,
     required this.todayRecovery,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered,
     required this.population

   });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.name),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.5, // Set a fixed height for the Card

                  child: Card(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * .06,),
                          ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                          ReusableRow(title: 'Total Deaths', value: widget.totalDeaths.toString()),
                          ReusableRow(title: 'Total Recovered', value: widget.totalRecovered.toString()),
                          ReusableRow(title: 'Population', value: widget.population.toString()),
                          ReusableRow(title: 'Tests', value: widget.test.toString()),
                          ReusableRow(title: 'Active', value: widget.active.toString()),
                          ReusableRow(title: 'Critical', value: widget.critical.toString()),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
