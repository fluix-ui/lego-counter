import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluix/fluix.dart';
import 'package:lego_count/models/my_sets.dart';
import 'package:lego_count/models/set.dart';
import 'package:lego_count/screens/export.dart';
import 'package:lego_count/utils/http.dart' as http;
import 'package:lego_count/utils/storage.dart' as storage;
import 'package:lego_count/widgets/custom_grid.dart';
import 'package:lego_count/widgets/grid_card.dart';
import 'package:lego_count/widgets/part_img.dart';
import 'package:provider/provider.dart';

class SetDetailsScreen extends StatelessWidget {
  final String id;

  SetDetailsScreen(this.id, {Key key}) : super(key: key);

  Future<LegoSet> getData() async {
    var local = await storage.getMySet(id);
    if (local != null) return local;
    return await http.getSet(id);
  }

  @override
  Widget build(BuildContext context) {
    return FluidShell(
      appBar: FluidBar(
        color: FluidTheme.of(context).primary.darker,
        title: Text("Set $id"),
        centerTitle: true,
        height: 80,
      ),
      body: ListView(padding: EdgeInsets.all(16), children: [
        FutureBuilder<LegoSet>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.data == null)
              return Center(
                child: CircularProgressIndicator(),
              );
            var item = snapshot.data;
            var width = MediaQuery.of(context).size.width;
            var theme = FluidTheme.of(context);
            MySets savedSets = Provider.of<MySets>(context);
            var selectedTab = 0;

            var tabs = FluidTabs(
              [
                FluidTab(
                  "Teile",
                  child: PartTab(item.parts),
                ),
                if (item.showExisting.isNotEmpty)
                  FluidTab(
                    "In Besitz",
                    child: PartTab(item.showExisting, show: TabQuantity.owned),
                  ),
                if (item.showMissing.isNotEmpty)
                  FluidTab(
                    "Fehlend",
                    child: PartTab(item.showMissing, show: TabQuantity.missing),
                  ),
                if (item.spareparts.isNotEmpty)
                  FluidTab(
                    "Ersatz",
                    child: PartTab(item.spareparts),
                  ),
              ],
              alignment: MainAxisAlignment.center,
              onChange: (int sel) => selectedTab = sel,
            );


            var cardContent = <Widget>[
              Text(item.id, style: theme.typography.xlargeBody),
              SizedBox(
                height: 15,
              ),
              Text(
                item.name,
                style: theme.typography.largeBody.copyWith(
                  color: Liquids.richBlack.lighter,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "${item.partNum} Teile - ${item.year}",
                style: theme.typography.smallBody.copyWith(
                  color: Liquids.richBlack.lighter,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              item.cached
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FluidIconButton(
                          icon: Icon(LiquidIcons.logistics),
                          child: Text("Zählen"),
                          onTap: () => Navigator.of(context)
                              .pushNamed('count/${item.id}'),
                        ),
                        FluidIconButton.highlight(
                          icon: Icon(LiquidIcons.exportfile),
                          child: Text("Exportieren"),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExportScreen(item,selectedTab),
                            ),
                          ),
                        ),
                        FluidIconButton(
                          icon: Icon(LiquidIcons.bin),
                          theme: FluidButtonTheme(
                            Liquids.transparent,
                            theme.errorColor,
                            activeBackground: theme.errorColor.withOpacity(0.2),
                          ),
                          onTap: () {
                            savedSets.remove(item);
                            item.cached = false;
                          },
                        )
                      ],
                    )
                  : FluidIconButton.primary(
                      icon: Icon(LiquidIcons.add),
                      child: Text("Hinzufügen"),
                      onTap: () {
                        item.cached = true;
                        savedSets.add(item);
                      }),
            ];
            return Column(
              children: <Widget>[
                FluidCard(
                  alignChild: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                  child: ResponsiveWidget(
                    fallback: Center(child: Text("error")),
                    mobile: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CachedNetworkImage(
                          width: width / 2,
                          imageUrl: item.img,
                          placeholder: (context, str) =>
                              CircularProgressIndicator(),
                        ),
                        ...cardContent
                      ],
                    ),
                    tablet: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CachedNetworkImage(
                          width: width / 3,
                          imageUrl: item.img,
                          placeholder: (context, str) =>
                              CircularProgressIndicator(),
                        ),
                        Expanded(
                          child: Column(
                            children: cardContent,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                tabs
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: FluidTab("Teile",selected: true,),
                // ),
                // PartTab(item.parts)
              ],
            );
          },
        )
      ]),
    );
  }
}

enum TabQuantity { quantity, owned, missing }

class PartTab extends StatelessWidget {
  final List<Part> parts;
  final TabQuantity show;

  PartTab(this.parts, {this.show = TabQuantity.quantity});

  String _getQuant(Part part) {
    if (show == TabQuantity.missing)
      return '${part.quantity - part.owned} / ${part.quantity}';
    if (show == TabQuantity.owned && part.owned == part.quantity)
      return '${part.owned}';
    if (show == TabQuantity.owned) return '${part.owned} / ${part.quantity}';
    return part.quantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    return CustomGrid(
      crossAxisCount: (MediaQuery.of(context).size.width / 140).round(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      //padding: EdgeInsets.all(16),
      children: List.generate(parts.length, (index) {
        Part part = parts[index];
        return FluidCard(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                PartImage(part),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  height: 33,
                  alignment: Alignment.bottomCenter,
                  color: Liquids.sensitiveGrey.withAlpha(200),
                  child: Column(
                    children: <Widget>[
                      Text(
                        _getQuant(part),
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        part.name,
                        style: TextStyle(
                            fontSize: 12, color: Liquids.richBlack.lighter),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
          ),
        );
      }),
    );
  }
}
