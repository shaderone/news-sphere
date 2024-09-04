import 'dart:convert';

import 'package:newsapplication/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=54145bc9681c42de9a6cc831aa90502b";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData["articles"].forEach((element) {
        if (element["id"] != null || element['title'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element["title"] ?? " No Data Available",
            description: element["description"] ?? " No Data Available",
            url: element["url"] ?? "",
            urlToImage: element["urlToImage"] ?? "",
            published: element["publishedAt"] ?? " No Data Available",
            author: element["author"] ?? " No Data Available",
          );
          news.add(articleModel);
        }
      });
    }
  }
}
