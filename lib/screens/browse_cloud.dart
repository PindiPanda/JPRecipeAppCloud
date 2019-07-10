import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jp_recipe_cloud/model/recipe.dart';
import 'package:jp_recipe_cloud/screens/new_cloud.dart';


class BrowseScreenCloud extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RecipeListStateCloud();
}
class RecipeListStateCloud extends State {
  List<Recipe> recipes = List<Recipe>();
  Widget build(BuildContext context) {
    getRecipeData();
    return CupertinoPageScaffold(
      navigationBar:CupertinoNavigationBar(
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.add),
          onPressed: (){
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) => RecipeNewCloud(Recipe('',''))));
          },
        )
      ),
      child: recipeListItemsCloud(),
    );
  }
  ListView recipeListItemsCloud(){
    return ListView.builder(
      itemCount: recipes.length + 1,
      itemBuilder: (context, index) {
        if (index == 0){
          return Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 15.0, right: 15.0),
            child: Text(
            "Browse", 
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
            )
          );
        }
        return Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: Icon(CupertinoIcons.news),
            title: Text(
              this.recipes[index - 1].title,
              style: CupertinoTheme.of(context).textTheme.textStyle
            ),
            contentPadding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
            onTap: (){
              navigateToDetail(this.recipes[index - 1]);
            },
          ),
        ));
      },
    ); 
  }

  getRecipeData() async{
    List<Recipe> recipeList = List<Recipe>();
    await Firestore.instance
    .collection('recipes')
    .snapshots()
    .listen((data){
      data.documents.forEach((doc) {
        recipeList.add(Recipe(doc["title"], doc["instructions"]));
      });
    });
    setState((){
      recipes = recipeList;
    });
  }

  void navigateToDetail(Recipe recipe) async{
    bool result = await Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => RecipeNewCloud(recipe)),
    );
    if(result == true){
      getRecipeData();
    }
  }
}