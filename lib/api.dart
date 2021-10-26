import 'dart:convert';
import 'package:http/http.dart' as http;


Future<List<dynamic>> getData() async {
  final http.Response response = await http.get(Uri.parse('https://api.github.com/users/JakeWharton/repos?page=1&per_page=15'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('failed to load data');
  }
}

class ApiData{
  final List<Data>? data;

  ApiData({required this.data});
  factory ApiData.fromJson(Map<String, dynamic> json){
    var listData = json['data'] as List;
    List<Data> dataList = listData.map((i) => Data.fromJson(i)).toList();

    return ApiData(data: json[dataList]);
  }
}


class Data {
  final String size;
  final String language;
  final String watchers_count;
  final String description;
  final String name;
  final String open_issues;

  Data({
    required this.size,
    required this.language,
    required this.watchers_count,
    required this.description,
    required this.name,
    required this.open_issues
  });

  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
      size: parsedJson['size'],
      language: parsedJson['language'],
      watchers_count: parsedJson['watchers_count'],
      description: parsedJson['description'],
      name: parsedJson['name'],
      open_issues: parsedJson['open_issues']

    );
  }
}
