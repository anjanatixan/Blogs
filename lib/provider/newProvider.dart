import 'package:flutter/material.dart';
import 'package:noviindus/helper/navigation.dart';
import 'package:noviindus/helper/utils.dart';
import 'package:noviindus/models/detailsModel.dart';
import 'package:noviindus/models/newsBlogsModel.dart';
import 'package:noviindus/models/newsListModel.dart';
import 'package:noviindus/repo/NewsRepo.dart';

class NewsProvider with ChangeNotifier{
  NewsBlogsModel? newsBlogsModel;
  NewsListModel? newsListModel;
  DetailsModel? detailsModel;
 NewsRepo newsRepo=NewsRepo();
 var categoryId=0;
 var id;

 int currentCount = 1;

  setCurrentCount(int num) {
    this.currentCount = num;
  }

 setId(var id){
  this.id=id;
 }

 setCategoryId(var id){
  this.categoryId=id;
 }


  fetchNews()async{
    showLoading(getContext());
    await newsRepo.getNewslist();
    NavigationUtils.goBack(getContext());
  }

   fetchDetails()async{
    showLoading(getContext());
    await newsRepo.getDetails();
    NavigationUtils.goBack(getContext());
  }
  

  setNews(NewsBlogsModel model){
    this.newsBlogsModel=model;
    notifyListeners();
  }

   fetchNewsList()async{
    showLoading(getContext());
    await newsRepo.NewsDataList(currentCount);
    NavigationUtils.goBack(getContext());
  }

   fetchMoreNewsList()async{
    currentCount = currentCount + 1;
    showLoading(getContext());
    await newsRepo.NewsDataList(currentCount);
    NavigationUtils.goBack(getContext());
  }

  setNewList(NewsListModel model){
    this.newsListModel=model;
    
    notifyListeners();
  }

  setDetails(DetailsModel model){
    this.detailsModel=model;
    
    notifyListeners();
  }
}