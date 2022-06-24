import 'dart:convert';

import '../models/video_model.dart';

import 'package:http/http.dart' as http;

class ApiService {
  // Base Url of API
  String baseUrl = 'http://dktodoapi.herokuapp.com/api';

  // get List of Vidoes Method (this will return list of Videos)
  Future<List<Videos>> getListOfVideos() async {
    // create api url for Vidoes endpoint
    var url = Uri.parse('$baseUrl/videos');
    // send get request on /videos endpoint
    var response = await http.get(url);

    // check if response for /videos endpont is good or not
    if (response.statusCode == 200) {
      // if response is good

      // storing response body for api
      String data = response.body;

      // decoding form json to dart object
      var decodedData = jsonDecode(data);

      // getting "data" form decodedData
      var vidoesFromApiData = decodedData['data'];

      // encoding "data" to json for creating list of Videos form Vidoes Model
      var listOfVidoesInJson = jsonEncode(vidoesFromApiData);

      // List of Videos data-Model
      List<Videos> listOfVidoes = videosFromJson(listOfVidoesInJson);

      return listOfVidoes;
    } else {
      // if response is not good

      // print response status code
      print(response.statusCode);

      // return empty list
      return [];
    }
  }
}
