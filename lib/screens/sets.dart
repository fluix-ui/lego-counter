import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluix/fluix.dart';
import 'package:lego_count/models/my_sets.dart';
import 'package:lego_count/models/sets.dart';
import 'package:lego_count/widgets/bottom_loader.dart';
import 'package:lego_count/widgets/grid_card.dart';
import 'package:lego_count/utils/http.dart' as http;
import 'package:provider/provider.dart';

class SetsScreen extends StatelessWidget {
  TextEditingController searchControl = TextEditingController();

  SetsScreen() {}

  ScrollController controller;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    LegoSets sets = LegoSets();
    MySets savedSets = Provider.of<MySets>(context);

        openDetails(LegoSet item){
      Navigator.of(context).pushNamed('/set/' + item.id);
    }

    buildGridTile(LegoSet sett) {
      return GridCard(
          child: Column(
            children: <Widget>[
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: sett.getImg(),
                  errorWidget: (context,str,_) => Center(child: Text("Bild nicht erreichbar")),
                  placeholder: (context,str) => Center(child: CircularProgressIndicator()),
                ),
              ),
              Text(
                sett.name,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
              Text(sett.id, style: TextStyle(fontSize: 10)),
            ],
          ),
          onTap: () {
            openDetails(sett);
          });
    }

    onSearch([String str]) {
      if(str != null) searchControl.text = str;
      sets.clear();
      http.getSets(searchControl.text).then((json){
        if(json["count"] == 0) return;
        sets.addJson(json);
        if(sets.sets.length == 1){
          openDetails(sets.sets[0]);
          searchControl.text = "";
          sets.clear();
        } 
      });
    }

    _scrollListener() {
      if (controller.position.pixels >
          controller.position.maxScrollExtent - 10) {
        sets.pagination++;
        http
            .getSets(searchControl.text, sets.pagination)
            .then((json) => sets.addJson(json));
      }
    }

    controller = new ScrollController()..addListener(_scrollListener);

    onSearch();

    return Material(
      child: FluidShell(
        // sideBar: FluidSidebar(
        //   children: <Widget>[
        //     SidebarItem(
        //       icon: Icon(LiquidIcons.search),
        //       title: "Sets",
        //       selected: true,
        //       showIconDescription: false,
        //     ),
        //     SidebarItem(
        //       icon: Icon(LiquidIcons.gridviewOutline),
        //       title: "Meine Sets",
        //       showIconDescription: false,
        //     ),
        //   ],
        // ),
        appBar: FluidBar(
          color: Liquids.vibrantCyan.darker,
          title: Text("Sets"),
          height: 80,
          actions: <Widget>[
            SizedBox(
              width: deviceWidth / 2.5,
              child: FluidInput(
                controller: searchControl,
                hintText: "Suchen...",
                textInputAction: TextInputAction.search,
                onSubmitted: (String str) => onSearch(str),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            FluidIconButton.highlight(
              icon: Icon(LiquidIcons.search),
              onTap: () => onSearch(),
            )
          ],
        ),
        body: StatefulBuilder(
          builder: (context, setState) {
            sets.addListener(() => setState(() => null));
            return GridView.count(
              controller: controller,
              crossAxisCount: (deviceWidth / 140).round(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              padding: EdgeInsets.all(16),
              children: List.generate(sets.sets.length, (index) {
                return buildGridTile(sets.sets[index]);
              }),
            );
          },
        ),
      ),
    );
  }
}
