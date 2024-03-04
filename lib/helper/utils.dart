import 'dart:ui';

import 'package:flutter/material.dart';

import 'navigation.dart';

showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Container(
          color: Colors.white.withOpacity(0.1),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: Stack(
                  children: [spinkit],
                ),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      );
    },
  );
}
BuildContext getContext() {
  return NavigationService.navigatorKey.currentContext!;
}

showToast(BuildContext context, String message, Color color, Color textcolor) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    dismissDirection: DismissDirection.down,
    content: Text(
      message,
      style: TextStyle(color: textcolor, ),
    ),
    behavior: SnackBarBehavior.fixed,
    duration: Duration(seconds: 3),
  ));
}

getWidth(BuildContext context) => MediaQuery.of(context).size.width;
getHeight(BuildContext context) => MediaQuery.of(context).size.height;

 hideKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  String removeHtmlTags(String htmlText) {
  return htmlText.replaceAll(RegExp(r'<[^>]*>'), '');
}

String timeAgo(DateTime d) {
 Duration diff = DateTime.now().difference(d);
 if (diff.inDays > 365)
  return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
 if (diff.inDays > 30)
  return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
 if (diff.inDays > 7)
  return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
 if (diff.inDays > 0)
  return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
 if (diff.inHours > 0)
  return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
 if (diff.inMinutes > 0)
  return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
 return "just now";
}