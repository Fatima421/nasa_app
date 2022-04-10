import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'apiService/apiService.dart';


class detailWidget extends StatefulWidget {
  final String title;
  final String copyright;
  final String date;
  final String url;
  final String explanation;

  detailWidget(this.title, this.copyright, this.date, this.url, this.explanation);

  @override
  State<detailWidget> createState() => _detailWidgetState();
}

class _detailWidgetState extends State<detailWidget> {
  File? _displayImage;
  bool addFavorite = false;

  Future<void> _download() async {
    final response = await http.get(Uri.parse(widget.url));

    final imageName = path.basename(widget.url);
    final appDir = await path_provider.getApplicationDocumentsDirectory();

    final localPath = path.join(appDir.path, imageName);

    // Downloading
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ApiService apiService = ApiService();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(children: <Widget>[
            Container(
              width: double.infinity,
              height: size.height * 0.5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          widget.url),
                      fit: BoxFit.cover)),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height * 0.40),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(),
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20, top:35, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(widget.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 25.0)),
                        const SizedBox(
                          width: 120,
                        ),
                        IconButton(
                           icon: Icon(addFavorite ? Icons.favorite : Icons.favorite_border),
                           iconSize: 40,
                           
                          onPressed: () async {
                            print("fav click");
                            String id = await getId();
                            bool fav = await apiService.markFav(id, widget.date, widget.explanation, widget.title, widget.url, widget.copyright);
                            setState(() {
                              addFavorite = !addFavorite;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(widget.copyright,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0)),
                    Text(
                      widget.date,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15.0),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(widget.explanation,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 15.0),
                    ),
                    IconButton(
                      onPressed: () async {
                      final uri = Uri.parse(widget.url);
                      final response = await http.get(uri);
                      final bytes = response.bodyBytes;
                            
                      Directory temp = await path_provider.getTemporaryDirectory();
                      final path = '${temp.path}/image.jpg';
                            File(path).writeAsBytesSync(bytes);
                      
                      await Share.shareFiles([path], text: widget.title + "\n" + widget.date);
                      
                      },
                      icon: const Icon(Icons.share)
                    ),
                    ElevatedButton(
                      onPressed: _download, 
                      child: const Text('Download')),
                      const SizedBox(height: 25),
                      _displayImage != null ? Image.file(_displayImage!) : Container()
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

getId() async {
  final prefs = await SharedPreferences.getInstance();
  final String? id = prefs.getString('id');
  return id;
}

