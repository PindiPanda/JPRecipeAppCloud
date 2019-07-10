import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:jp_recipe_cloud/model/recipe.dart';


class TestScreenCloud extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RecipeListState();
}

class RecipeListState extends State{
  int count = 0;
  List<Recipe> recipes = List<Recipe>();
  TextEditingController testController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getRecipeData();
    return CupertinoPageScaffold(
      //navigationBar: CupertinoNavigationBar(),
      child: Center(
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 100, bottom: 10),
            child: StreamBuilder(
            stream: Firestore.instance.collection('recipes').document('notes').snapshots(),
            builder:(context, snapshot){
              if (snapshot.hasData){
                var doc = snapshot.data;
                if (doc.exists){
                  return Text(doc['quick'], style: CupertinoTheme.of(context).textTheme.navTitleTextStyle);
                }
              }
             return CupertinoActivityIndicator();
            },
          )),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
            child:CupertinoTextField(
            controller: testController,
            style: CupertinoTheme.of(context).textTheme.textStyle,
            onEditingComplete: () {
              Firestore.instance.collection('recipes')
              .document('notes')
              .updateData({'quick': testController.text});
              testController.text = '';
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            textCapitalization: TextCapitalization.sentences,
            placeholder: 'Recipe',
          )),
          CupertinoButton.filled(
            child: Text("Reset"), 
            onPressed: () {
              Firestore.instance.collection('recipes').document('notes').updateData({'quick': 'This was written online!'});
            },
          ),
          Text(recipes.toString())
        ])
      )
    );
  }
  getRecipeData() async{
    List<Recipe> recipeList = List<Recipe>();
    int count = 0;
    await Firestore.instance
    .collection('recipes')
    .snapshots()
    .listen((data){
      data.documents.forEach((doc) {
        count++;
        recipeList.add(Recipe(doc["title"], doc["instructions"]));
      });
    });
    setState((){
      this.recipes = recipeList;
      this.count = count;
    });
  }
}