import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

  
class AppCustomWidget {

  static Image loadingImage = Image.asset("assets/loading_item.gif");

  static Column loadingData = Column(
    children: [
      ConstrainedBox(
        constraints: BoxConstraints.tight(Size.square(100)),
        child: loadingImage
      ),
      const Text("Loading data, please wait...")
    ],
  );

  static Image itemSlot = Image.asset(
    "assets/item-bg.png",
    width: double.maxFinite,
    height: double.maxFinite,
    filterQuality: FilterQuality.none,
    fit: BoxFit.contain,
  );

  static Image menuItemSlot = Image.asset(
    "assets/menu_item_bg.png",
    width: double.maxFinite,
    height: double.maxFinite,
    filterQuality: FilterQuality.none,
    fit: BoxFit.contain,
  );

  static DecorationImage containerButton = DecorationImage(
    image: AssetImage("assets/button_bg.png"),
    filterQuality: FilterQuality.none,
    fit: BoxFit.fitWidth,
  );

  static DecorationImage containerSmallButton = DecorationImage(
    image: AssetImage("assets/button_bg_small.png"),
    filterQuality: FilterQuality.none,
    fit: BoxFit.fill,
  );

  
}