import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/utility/model.dart';
import 'package:final_project/utility/my_style.dart';
import 'package:final_project/utility/showpreview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _folded = true;
  String name, email;
  List<Widget> _animelist = [];
  List<ListAnime> listanime= [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findNameandEmail();
    animeList();
  }

  Future<Null> animeList() async {
    await Firebase.initializeApp().then((value) async {
      print('initialize Success');
      await FirebaseFirestore.instance
          .collection('AnimeList')
          .snapshots()
          .listen((event) {
        print('snapshot = ${event.docs}');
        int index = 0;
        for (var snapshots in event.docs) {
          Map<String, dynamic> map = snapshots.data();
          print('map = $map');
          ListAnime anime = ListAnime.fromMap(map);
          listanime.add(anime);
          print('name= ${anime.name}');
          setState(() {
            _animelist.add(createWidget(anime, index));
          });
          index++;
        }
      });
    });
  }

  Widget createWidget(ListAnime anime, int index) => GestureDetector(onTap: (){
    print('You Click from index = $index');
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Showpreview(listAnime: listanime[index],)));
  },
    child: Card(color: Mystyle().lightColor,
      child: Center(
        child: Card(color: Mystyle().lightColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80.0,
                    child: Image.network(anime.cover),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(anime.name,style: TextStyle(fontSize: 15.0,color: Colors.white),),
                ],
              ),
            ),
      ),
    ),
  );

  Future<Null> findNameandEmail() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event.displayName;
          email = event.email;
        });
      });
    });
  }

  Widget showDrawer() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: Mystyle().primaryColor),
      currentAccountPicture: CircleAvatar(
        child: Icon(
          Icons.people,
          size: 37.0,
        ),
      ),
      accountName: Text(name == null ? 'Name' : name),
      accountEmail: Text(email == null ? 'email' : email),
    );
  }

  Widget showFavourite() => ListTile(
        leading: Icon(Icons.star),
        title: Text('Favourite List'),
        onTap: () {

        },
      );

  Widget showSetting() => ListTile(
        leading: Icon(Icons.settings_applications_outlined),
        title: Text('Setting'),
        onTap: () {},
      );

  Widget showmyAccout() => ListTile(
        leading: Icon(Icons.verified_user),
        title: Text('My Account'),
        onTap: () {},
      );

  Widget showlogOut() => ListTile(
        leading: Icon(Icons.logout),
        title: Text('Log Out'),
        onTap: () async {
          await Firebase.initializeApp().then((value) async {
            await FirebaseAuth.instance.signOut().then((value) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false));
          });
        },
      );

  Widget showAbout() => ListTile(
        leading: Icon(Icons.question_answer_sharp),
        title: Text('About'),
        onTap: () {},
      );

  Widget showDrawerList() {
    return Drawer(
      child: Container(
        color: Mystyle().lightColor,
        child: ListView(
          children: [
            showDrawer(),
            showFavourite(),
            showmyAccout(),
            showSetting(),
            showlogOut(),
            showAbout(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mystyle().primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Anime List"),
        backgroundColor: Mystyle().primaryColor,
        actions: [IconButton(icon: Icon(Icons.exit_to_app), onPressed: () {})],
      ),
      drawer: showDrawerList(),
      body: _animelist.length == 0
          ? CircularProgressIndicator()
          : GridView.extent(
              maxCrossAxisExtent: 300.0,
              children: _animelist,
            ),
      floatingActionButton: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        width: _folded ? 56 : 180,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: Mystyle().primaryColor,
            boxShadow: kElevationToShadow[5]),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16),
                child: !_folded
                    ? TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          border: InputBorder.none,
                        ),
                      )
                    : null,
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 400),
              child: InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Icon(
                    _folded ? Icons.search_rounded : Icons.close,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _folded = !_folded;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
