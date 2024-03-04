import 'dart:convert';
import 'dart:developer';
import 'package:noviindus/apiServices/urls.dart';
import 'package:noviindus/apiServices/webService.dart';
import 'package:noviindus/helper/utils.dart';
import 'package:noviindus/models/detailsModel.dart';
import 'package:noviindus/models/newsBlogsModel.dart';
import 'package:noviindus/models/newsListModel.dart';
import 'package:noviindus/provider/newProvider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class NewsRepo{
  ApiService _service = ApiService();


   Future<String> getNewslist() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
     "Authorization": "Bearer ${"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzk1MjYzMjg4LCJpYXQiOjE3MDg4NjMyODgsImp0aSI6IjEzNTUzMjE5NWI5ODRmOTliZjUyOTEyZGRmODlkZWNmIiwidXNlcl9pZCI6MjF9.HUU-OfGaRHB0-_Sx9BYxVpgyPE_VHeS_hLRxlANQedI"}"
    };

    final response = await _service.getResponse(Urls.NEWS_BLOGS, headers);

    if (response.statusCode == 202) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      NewsBlogsModel model = NewsBlogsModel.fromJson(responseBody);
      getContext().read<NewsProvider>().setNews(model);
      log("message" + responseBody.toString());
    } else {
        log("message1");
    }
    return "";
  }


   Future<String> NewsDataList(var currentCount) async {
    Map<String, String> headers = {
      "Content-Type": "application/x-www-form-urlencoded",
    };

  
    var body = {
      "category": getContext().read<NewsProvider>().categoryId,
    };
    log("//////"+getContext().read<NewsProvider>().categoryId.toString());

    var formData = body.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    final response = await http.post(
        Uri.parse("https://the-flutter-case-prod.noviindus.in/api/news-and-blogs-catg?page=${currentCount}"),
        body: formData,
        headers: headers);

    // Check the response status code
    if (response.statusCode == 200) {
     
      final responseBody = jsonDecode(response.body);
      NewsListModel model = NewsListModel.fromJson(responseBody);
      getContext().read<NewsProvider>().setNewList(model);
      
      log("message" + responseBody.toString());
    } else {
    
    }

    return "";
  }

  Future<String> getDetails() async {
    // Map<String, String> headers = {
    //   // "Content-Type": "application/json",
    // };

    // final response = await _service.getResponse(Urls.NEWS_BLOGS_DETAILS, headers);
     final response =await await http.get(Uri.parse("https://the-flutter-case-prod.noviindus.in/api/news-and-blogs-details/"+getContext().read<NewsProvider>().id.toString()));
log(response.statusCode.toString());
    if (response.statusCode == 202) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      DetailsModel model = DetailsModel.fromJson(responseBody);
      getContext().read<NewsProvider>().setDetails(model);
      log("message" + responseBody.toString());
    } else {
        log("message1");
    }
    return "";
  }

}