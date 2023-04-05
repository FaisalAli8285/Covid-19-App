import 'dart:convert';

import 'package:covid_app/views/world_states.dart';
import 'package:http/http.dart' as http;

import '../model/world_state_model.dart';
import '../utilities/app_url.dart';

class StatesServices {
  Future<WorldStateModel> fetchWorldStateRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<List<dynamic>> countriesListApi() async {
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data;
      data = jsonDecode(response.body);

      return data;
    } else {
      throw Exception("Error");
    }
  }
}
