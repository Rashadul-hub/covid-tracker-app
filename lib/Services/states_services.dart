
import 'dart:convert';

import 'package:covid_tracker_app/Model/countries_list_model.dart';
import 'package:covid_tracker_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart'as http;

import '../Model/world_states_model.dart';

class StatesServices{

  Future<WorldStatesModel> fetchWorldStatesRecords () async{

    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

    if(response.statusCode == 200){

      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);

    }else{
      throw Exception('Error');
    }

  }



  List<CountriesListModel> countryList =[];

  Future<List<CountriesListModel>> countriesListApi () async{

    final response = await http.get(Uri.parse(AppUrl.countriesListApi));
    var data = jsonDecode(response.body);

    if(response.statusCode == 200){
      for (Map i in data){
        countryList.add(CountriesListModel.fromJson(i));
      }

      return countryList;

    }else{
      return countryList;
    }

  }



  Future<List<dynamic>> countriesApi () async{

    var data;
    final response = await http.get(Uri.parse(AppUrl.countriesListApi));

    if(response.statusCode == 200){

       data = jsonDecode(response.body);
      return data;

    }else{
      throw Exception('Error');
    }

  }

}