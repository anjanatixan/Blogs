import 'package:flutter/material.dart';
import 'package:noviindus/apiServices/urls.dart';
import 'package:noviindus/helper/utils.dart';
import 'package:noviindus/provider/newProvider.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
     Future.delayed(Duration(seconds: 0), () async {
    await getContext().read<NewsProvider>().fetchDetails();
    });
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_circle_left_outlined, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<NewsProvider>(
        builder: (context,provider,child) {
          return provider.detailsModel!=null?
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            // NavigationUtils.goNext(context, DetailsScreen());
                          },
                          child: Container(
                            height: 150,
                            width: getWidth(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                     Urls.IMAGE_URL+
                                               provider.detailsModel!.blog.image.toString()
                                              
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
                                      Text(" ${timeAgo(provider.detailsModel!.blog.createdAt)}"),
                                    ],
                                  ),
                                )))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      provider.detailsModel!.blog.title,
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10,),
                    Container(
                        color: Colors.grey.shade100,
                        height: 35,
                        width: getWidth(context),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Updated on : ${provider.detailsModel!.blog.createdAt.toString().split(" ").first}",
                            style: TextStyle(color: Colors.green),
                            textAlign: TextAlign.start,
                          ),
                        )),
                        SizedBox(height: 10,),
                          Text(
                    removeHtmlTags(provider.detailsModel!.blog.content),
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ):Container();
        }
      ),
    );
  }
}
