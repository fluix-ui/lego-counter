import 'package:flutter/material.dart';
import 'package:fluix/fluix.dart';
import 'package:lego_count/models/my_sets.dart';
import 'package:lego_count/models/set.dart';
import 'package:lego_count/utils/storage.dart' as storage;
import 'package:lego_count/widgets/custom_grid.dart';
import 'package:lego_count/widgets/grid_card.dart';
import 'package:lego_count/widgets/part_img.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class CountScreen extends StatelessWidget {
  CountScreen();

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;

    bool isList = false;
    MySets mysets = Provider.of<MySets>(context);
    var theme = FluidTheme.of(context);

    return FutureBuilder<LegoSet>(
        future: storage.getMySet(id),
        builder: (context, snapshot) {
          var item = snapshot.data;
          var dataparts = item != null ? item.parts : null;
          List<Part> parts = dataparts;

          search(String input) {
            parts = dataparts
                .where((part) =>
                    part.name.contains(input) ||
                    part.id.contains(input) ||
                    (part.length != null &&
                        input.contains(part.length.toString())))
                .toList();
          }

          return StatefulBuilder(
            builder: (context, setState) => FluidShell(
                appBar: FluidBar(
                  color: theme.primary.darker,
                  title: Text("Set $id zählen"),
                  centerTitle: true,
                  height: 80,
                  actions: <Widget>[
                    FluidIconButton.ghost(
                      icon: Icon(
                          isList ? LiquidIcons.gridview : LiquidIcons.listview),
                      onTap: () => setState(() {
                        isList = !isList;
                      }),
                      color: Liquids.white,
                    ),
                    FluidIconButton.highlight(
                      icon: Icon(Icons.save),
                      onTap: () => mysets.update(item),
                    )
                  ],
                ),
                body: ListView(
                  children: <Widget>[
                    Builder(
                      builder: (context) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            snapshot.data == null)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        return Column(
                          children: isList
                              ? [
                                  ListCounter(parts),
                                  if (item.spareparts != null &&
                                      item.spareparts.isNotEmpty)
                                    Text("Ersatzteile",
                                        style: theme.typography.h3),
                                  ListCounter(item.spareparts),
                                ]
                              : <Widget>[
                                  GridCounter(parts),
                                  if (item.spareparts != null &&
                                      item.spareparts.isNotEmpty)
                                    Text("Ersatzteile",
                                        style: theme.typography.h3),
                                  GridCounter(item.spareparts)
                                ],
                        );
                      },
                    ),
                  ],
                )),
          );
        });
  }
}

class GridCounter extends StatefulWidget {
  final List<Part> parts;
  GridCounter(this.parts);

  @override
  _GridCounterState createState() => _GridCounterState();
}

class _GridCounterState extends State<GridCounter> {
  List<Part> parts;

  @override
  void initState() {
    parts = widget.parts.where((part) => part.owned != part.quantity).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomGrid(
      crossAxisCount: (MediaQuery.of(context).size.width / 140).round(),
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: parts
          .map<Widget>(
            (part) => GridCard(
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: <Widget>[
                    PartImage(part),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      height: 20,
                      alignment: Alignment.center,
                      color: Liquids.sensitiveGrey.lighter.withAlpha(100),
                      child: Text("${part.owned} / ${part.quantity}"),
                    ),
                  ],
                ),
              ),
              onTap: () => setState(() {
                part.increaseOwned();
                if (part.owned == part.quantity) parts.remove(part);
              }),
              onDoubleTap: () => setState(() {
                part.decreaseOwned();
              }),
            ),
          )
          .toList(),
    );
  }
}

class ListCounter extends StatefulWidget {
  final List<Part> parts;
  ListCounter(this.parts);

  @override
  _ListCounterState createState() => _ListCounterState();
}

class _ListCounterState extends State<ListCounter> {
  List<Part> parts;

  @override
  void initState() {
    parts = widget.parts;
    parts.sort((a, b) => b.quantity.compareTo(a.quantity));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FluidList(
      backgroundColor: Liquids.white,
      children: parts.map<Widget>((part) {
        TextEditingController controller =
            TextEditingController(text: part.owned.toString());
        return FluidListItem(
          leading: FadeInImage.memoryNetwork(
            image: part.img,
            placeholder: kTransparentImage,
            width: 50,
          ),
          title: LayoutBuilder(
            builder: (context, size) => Container(
              constraints: BoxConstraints(maxWidth: size.maxWidth / 1.5),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                part.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          onTap: () => part.increaseOwned(),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${part.quantity}"),
              ),
              SizedBox(
                width: 50,
                child: FluidInput(
                  decoration: InputDecoration(fillColor: Liquids.sensitiveGrey),
                  //controller: controller,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  // onEditingComplete: () {
                  //   if(controller.text == part.owned.toString()) return;
                  //   int val = int.tryParse(controller.text);
                  //   if(val != null && val >= 0){
                  //     if(val > part.quantity) val = part.quantity;
                  //     part.owned = val;
                  //   }
                  //   controller.text = part.owned.toString();
                  // },
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
