import 'package:flutter/cupertino.dart';
import 'package:jp_recipe_cloud/screens/browse_cloud.dart';
import 'package:jp_recipe_cloud/screens/test_cloud.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'JPs Recipes Cloud',
      home: BrowseScreenCloud(),
    );
  }
}
