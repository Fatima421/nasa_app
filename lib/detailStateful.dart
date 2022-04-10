import 'package:flutter/material.dart';

import 'apiService/apiService.dart';
import 'detail.dart';
import 'model/apod.dart';

class DetailStateful extends StatefulWidget {
  const DetailStateful({ Key? key }) : super(key: key);

  @override
  _DetailStatefulState createState() => _DetailStatefulState();
}

class _DetailStatefulState extends State<DetailStateful> {
  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService();

    return MaterialApp(
      title: 'Fetch Data Example',
      home: Scaffold(
        body: Center(
          child: FutureBuilder<Apod>(
            future: apiService.getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //return Text(snapshot.data!.title);
                return detailWidget(snapshot.data!.title, snapshot.data!.copyright, snapshot.data!.date, snapshot.data!.url, snapshot.data!.explanation);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }else{
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}