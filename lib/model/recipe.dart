import 'dart:io';
import 'package:flutter/cupertino.dart';


class Recipe{
  
  int id;
  String title;
  String instructions;
  Image image;
  String imagePath;

  Recipe(this.title, this.instructions);
  Recipe.withID(this.id, this.title, this.instructions);
  /*Recipe.withImage(int _id, String _title, String _instructions, String imagePath){
    id = _id;
    title = _title;
    instructions = _instructions;
    image = Image.file(imagePath);
  }*/

  Future<Map<String,dynamic>> toMap() async{
    Map map = Map<String, dynamic>();
    map = Map<String, dynamic>();
    map["title"] = title;
    map["instructions"] = instructions;
    if (id != null){
      map["id"] = id;
    }
    if (imagePath != null){
      map["imagePath"] = imagePath;
    }
    return map;
  }

  Recipe.fromObject(dynamic object){
    id = object["id"];
    //debugPrint(this.id.toString());
    title = object["title"];
    //debugPrint(this.title);
    instructions = object["instructions"];
    //debugPrint(this.instructions);
    if (object["imagePath"] != null){
      this.imagePath = object["imagePath"];
      //debugPrint(this.imagePath);
      image = Image.file(File(imagePath));
    }
  }
}