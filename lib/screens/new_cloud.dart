import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:jp_recipe_cloud/model/recipe.dart';

class RecipeNewCloud extends StatefulWidget{
  final Recipe recipe;
  RecipeNewCloud(this.recipe);
  @override
  State<StatefulWidget> createState() => RecipeEditStateCloud(recipe);
}

class RecipeEditStateCloud extends State{
  TextEditingController titleController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();
  Recipe recipe;
  RecipeEditStateCloud(this.recipe);
  @override
  Widget build(BuildContext context) {
    titleController.text = recipe.title;
    instructionsController.text = recipe.instructions;
    return CupertinoPageScaffold(
      child: Padding(padding: EdgeInsets.only(top: 50.0),
      child: ListView(children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
          child: Text(
            recipe.title != ''? recipe.title : 'New Recipe',
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          )
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
          child:CupertinoTextField(
            controller: titleController,
            style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            onChanged: (value) {
              recipe.title = titleController.text;
            },
            textCapitalization: TextCapitalization.sentences,
            placeholder: 'Recipe',
          )
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child:CupertinoTextField(
            controller: instructionsController,
            style: CupertinoTheme.of(context).textTheme.textStyle,
            onChanged: (value){
              recipe.instructions = instructionsController.text;
            },
            placeholder: 'Instructions',
            minLines: null,
            maxLines: null,
            expands: true,
          )
        ),
        Padding(
          padding: EdgeInsets.all(15.0), 
          child: CupertinoButton(
            color: CupertinoColors.activeOrange,
            child: Text("Save"),
            onPressed: saveRecipeCloud(recipe),
          )
        ),
        /*Padding(
          padding: EdgeInsets.only(left: 15.0, right: 15.0), 
          child: CupertinoButton(
            disabledColor: Colors.transparent,
            color: CupertinoColors.activeOrange,
            child: Text("Delete"),
            onPressed: deleteRecipe(recipe),
          )
        ),*/
      ],))
    );
  }
  saveRecipeCloud(Recipe recipe){
    return(){Firestore.instance
                      .collection('recipes')
                      .document(recipe.title)
                      .setData({
                        'title': recipe.title, 
                        'instructions': recipe.instructions
                       });
    };
  }
  
}