import 'package:flutter/material.dart';
import 'package:fluix/fluix.dart';
import 'package:lego_count/models/my_sets.dart';
import 'package:lego_count/models/sets.dart';
import 'package:lego_count/screens/import.dart';
import 'package:lego_count/utils/storage.dart';
import 'package:lego_count/widgets/grid_card.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MySetsScreen extends StatelessWidget {
  TextEditingController searchControl = TextEditingController();

  MySetsScreen();

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    //LegoSets sets = Provider.of<LegoSets>(context);
    MySets savedSets = Provider.of<MySets>(context);

    List<Widget> buildChildren(sets) {
      if (sets == null) return [];
      return sets
          .map<Widget>((sett) => GridCard(
                child: AspectRatio(
                    aspectRatio: 1,
                    child: Column(
                      children: <Widget>[
                        FadeInImage.memoryNetwork(
                          image: sett.img,
                          placeholder: kTransparentImage,
                          height: 95,
                        ),
                        Text(
                          sett.name,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(sett.id, style: TextStyle(fontSize: 10)),
                      ],
                    )),
                onTap: () {
                  Navigator.of(context).pushNamed('/set', arguments: sett.id);
                },
              ))
          .toList();
    }

    onSearch() {
      // savedSets.clear();
      // savedSets.addAll(getMySets());
      //sets.clear();
      //http.getSets(searchControl.text).then((List json) => sets.addJson(json));
    }

    // onSearch();

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
          color: FluidTheme.of(context).primary.darker,
          title: Text("Gespeicherte Sets"),
          height: 80,
          actions: <Widget>[
            // SizedBox(
            //   width: deviceWidth / 2.5,
            //   child: FluidInput(
            //     controller: searchControl,
            //     hintText: "Suchen...",
            //     textInputAction: TextInputAction.search,
            //     onSubmitted: (String str) => onSearch(),
            //   ),
            // ),
            // SizedBox(
            //   width: 8,
            // ),
            // FluidIconButton.highlight(
            //   icon: Icon(LiquidIcons.search),
            //   onTap: () => onSearch(),
            // )
            FluidIconButton.highlight(
              icon: Icon(LiquidIcons.documentOutline),
              child: Text("Importieren"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImportScreen(),
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder<List<LegoSet>>(
          future: getMySets(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return AspectRatio(
                aspectRatio: 1,
                child: Container(
                  width: 10,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
              );
            return GridView.count(
              crossAxisCount: (deviceWidth / 150).round(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              padding: EdgeInsets.all(16),
              children: [
                ...buildChildren(snapshot.data),
                GridCard(
                  child: Align(
                      child: Icon(LiquidIcons.plus,
                          size: 30, color: FluidTheme.of(context).primary)),
                  onTap: () {
                    Navigator.of(context).pushNamed('/sets');
                  },
                  color: Liquids.sensitiveGrey.dark,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
