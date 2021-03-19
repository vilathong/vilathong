import 'package:final_project/utility/model.dart';
import 'package:flutter/material.dart';

class Showpreview extends StatefulWidget {
  final ListAnime listAnime;
  Showpreview({Key key, this.listAnime}):super(key: key);
  @override
  _ShowpreviewState createState() => _ShowpreviewState();
}


class _ShowpreviewState extends State<Showpreview> {
  ListAnime model;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = widget.listAnime;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(model.name == null ? 'Read Anime': model.name ),),
   );
  }
}
