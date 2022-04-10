import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_app/apiService/apiService.dart';
import 'package:nasa_app/detail.dart';
import 'package:nasa_app/detailStateful.dart';
import 'package:nasa_app/model/apod.dart';
import 'package:path/path.dart';
import 'detail.dart';

class FavList extends StatefulWidget {
  const FavList({ Key? key }) : super(key: key);

  @override
  State<FavList> createState() => _FavListState();
}

class _FavListState extends State<FavList> {
  ApiService apiService = new ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder<List<Apod>>(
          future: apiService.getFav(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  child: GestureDetector(
                    onTap: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => detailWidget(snapshot.data![index].title, snapshot.data![index].copyright, snapshot.data![index].date, snapshot.data![index].url, snapshot.data![index].explanation)));
                    },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: const Color(0xff97FFFF),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${snapshot.data![index].title}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("${snapshot.data![index].explanation}"),
                      ],
                    ),
                  ),                   
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}