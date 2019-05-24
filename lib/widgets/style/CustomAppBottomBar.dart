import 'package:flutter/material.dart';
import 'package:masairline/util/util.dart';

class CustomAppBottomBar extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomBarItems = [];

  final bottomNavigationBarItemStyle =
      TextStyle(fontStyle: FontStyle.normal, color: Colors.black);

  CustomAppBottomBar() {
    var appTheme;
    bottomBarItems.add(
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: appTheme.primaryColor,
        ),
        title: Text(Util.explore, style: bottomNavigationBarItemStyle.copyWith(color: appTheme.primaryColor)),
      ),
    );
    bottomBarItems.add(
      new BottomNavigationBarItem(
        icon: new Icon(
          Icons.favorite,
          color: Colors.black,
        ),
        title: Text(
          Util.watchlist,
          style: bottomNavigationBarItemStyle,
        ),
      ),
    );
    bottomBarItems.add(
      new BottomNavigationBarItem(
        icon: new Icon(
          Icons.local_offer,
          color: Colors.black,
        ),
        title: Text(
          Util.deals,
          style: bottomNavigationBarItemStyle,
        ),
      ),
    );
    bottomBarItems.add(
      new BottomNavigationBarItem(
        icon: new Icon(
          Icons.notifications,
          color: Colors.black,
        ),
        title: Text(
          Util.notification,
          style: bottomNavigationBarItemStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15.0,
      child: BottomNavigationBar(
        items: bottomBarItems,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}