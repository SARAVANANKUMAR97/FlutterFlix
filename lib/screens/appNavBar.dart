import 'package:demo/screens/Search_screen.dart';
import 'package:demo/screens/hotTopics.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import 'Netflix_home.dart';

class Appnavbar extends StatelessWidget {
  const Appnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
              bottomNavigationBar: Container(
                color: Colors.black,
                height: 70,
                child: TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.home_sharp), text: "Home"),
                    Tab(icon: Icon(Iconsax.search_normal), text: "Search"),
                    Tab(
                      icon: Icon(Icons.photo),
                      text: "Hot News",
                    )
                  ],
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.white,
                  indicatorColor: Colors.transparent,
                ),
              ),
              body: TabBarView(children: [
                NetflixHome(),
                SearchScreen(),
                hotTopic(),
              ])),
        ));
  }
}
