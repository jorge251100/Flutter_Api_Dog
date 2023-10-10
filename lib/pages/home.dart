import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;
  List<DogData> dogDataList = [];

    final List<String> dogNames = [
    "Lucy",
    "Max",
    "Buddy",
    "Daisy",
    "Charlie",
    "Crokie",
    "Sammy",
    "Penny",
    "Daisy",
    "Archie",
  ];

  final List<String> dogAges = [
    "7 años",
    "4 años",
    "5 años",
    "3 años",
    "6 años",
    "12 años",
    "3 años",
    "8 años",
    "10 años",
    "2 años",
  ];

  @override
  void initState() {
    super.initState();
    _fetchDogData();
  }

  Future<void> _fetchDogData() async {
  try {
    String url = "https://dog.ceo/api/breeds/image/random/10";
    http.Response res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(res.body);
      final List<dynamic> dogImageUrls = responseData['message'];

      final List<DogData> dogDataList = dogImageUrls.map((url) {
        final dogName = dogNames[dogImageUrls.indexOf(url) % dogNames.length];
        final dogAge = dogAges[dogImageUrls.indexOf(url) % dogAges.length];

        return DogData(
          imageUrl: url,
          dogName: dogName,
          dogAge: dogAge,
        );
      }).toList();

      setState(() {
        this.dogDataList = dogDataList;
        _isLoading = false;
      });
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}



  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Dog API Example"),
    ),
    body: _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      dogDataList[index].imageUrl,
                      width: 200,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Name: ${dogDataList[index].dogName}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Age: ${dogDataList[index].dogAge}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: dogDataList.length,
          ),
  );
}

}

class DogData {
  final String imageUrl;
  final String dogName;
  final String dogAge;

  DogData({
    required this.imageUrl,
    required this.dogName,
    required this.dogAge,
  });
}

