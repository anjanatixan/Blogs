import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:noviindus/apiServices/urls.dart';
import 'package:noviindus/helper/navigation.dart';
import 'package:noviindus/helper/utils.dart';
import 'package:noviindus/provider/newProvider.dart';
import 'package:noviindus/views/detailsScreen.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
    ScrollController _controller = ScrollController();


  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () async {
      await getContext().read<NewsProvider>().fetchNews();
     await getContext().read<NewsProvider>().fetchNewsList();
        if (_controller.position.maxScrollExtent == _controller.offset) {
          showLoading(context);
          log("messag44e");
          await getContext().read<NewsProvider>().fetchMoreNewsList();
          NavigationUtils.goBack(context);
        }
    
    });

    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,elevation: 0,
        title:  Text(
                    'News & Blogs',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.black),
                  ) ,
      ),
      body: SafeArea(
        child: ListView(
          controller: _controller,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8,bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'News & Blogs',
                  //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  // ),
                  Consumer<NewsProvider>(builder: (context, provider, child) {
                    return provider.newsBlogsModel!=null?
                    
                    Container(
                        height: 30,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              provider.newsBlogsModel!.blogsCategory.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10, top: 10),
                              child: InkWell(
                                onTap: () async{
                                  setState(() {
                                    selectedIndex =index;
                                    
                                  });
                                  log(provider.newsBlogsModel!.blogsCategory[index].id.toString());
                                  await getContext().read<NewsProvider>().setCurrentCount(1);
                                  await getContext()
                                        .read<NewsProvider>()
                                        .setCategoryId(provider.newsBlogsModel!.blogsCategory[index].id);
                                         await getContext().read<NewsProvider>().fetchNewsList();
                                },
                                child: Text(
                                    provider.newsBlogsModel!.blogsCategory[index]
                                        .name,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: selectedIndex == index
                                            ? Colors.green
                                            : Colors.black)),
                              ),
                            );
                          },
                        )):Container();
                  }),
                  SizedBox(
                    height: 15,
                  ),
                  CarouselSlider(
                    items: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/meeting.jpg",
                                ),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/meeting.jpg",
                                ),
                                fit: BoxFit.cover)),
                      ),
                    ],
      
                    //Slider Container properties
                    //carousel Slider flutter
                    options: CarouselOptions(
                      height: 200.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 0.0,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 1.9,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest News',
                        style:
                            TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Read More  ',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Consumer<NewsProvider>(
                    builder: (context,provider,child) {
                      return provider.newsListModel!=null?
                      ListView.separated(
                        shrinkWrap: true,
                        controller: _controller,
                        physics:  NeverScrollableScrollPhysics(),
                        itemCount: provider.newsListModel!.results.length,
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  InkWell(
                                    onTap: () async{
                                       await getContext().read<NewsProvider>().setId(provider.newsListModel!.results[index].id);
                                       
                                      NavigationUtils.goNext(
                                          context, DetailsScreen());
                                         
                                    },
                                    child: Container(
                                      height: 150,
                                      width: getWidth(context),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(Urls.IMAGE_URL+
                                               provider.newsListModel!.results[index].image.toString(),
                                              ),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.timelapse_sharp,
                                                  size: 15,
                                                ),
                                                
                                                Text(" "+timeAgo(provider.newsListModel!.results[index].createdAt).toString()),
                                              ],
                                            ),
                                          )))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                provider.newsListModel!.results[index].title.toString(),
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                      //          ReadMoreText(removeHtmlTags(provider.newsListModel!.results[index].content)
                      // ,
                      // numLines: 3,
                      // readMoreText: "More",
                      // readMoreIconColor: Colors.green,
                      // readMoreTextStyle: TextStyle(color: Colors.green),
                      // readMoreAlign: Alignment.topLeft,
                      // readLessText: "Less"),
                              Text(
                               removeHtmlTags(provider.newsListModel!.results[index].content),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w300),maxLines: 3,overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5,)
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            thickness: 1,
                          );
                        },
                      ):Container();
                    }
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
