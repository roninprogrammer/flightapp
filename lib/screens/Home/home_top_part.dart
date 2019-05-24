import 'package:flutter/material.dart';
import 'package:masairline/bloc/app_bloc.dart';
import 'package:masairline/bloc/bloc_provider.dart';
import 'package:masairline/bloc/home_screen_bloc.dart';
import 'package:masairline/screens/flight/flight_list.dart';
import 'package:masairline/widgets/style/CustomShapeClipper.dart';
import 'package:masairline/widgets/style/ChoiceChip.dart';
import 'package:masairline/widgets/style/themes.dart';

import '../../main.dart';

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  AppBloc appBloc;
  HomeScreenBloc homeScreenBloc;
  var selectedLocationIndex = 0;
  var isFlightSelected = true;
  AppTheme appTheme;

  @override
  void initState() {
    super.initState();
    appBloc = BlocProvider.of<AppBloc>(context);
    homeScreenBloc = BlocProvider.of<HomeScreenBloc>(context);
  }

  @override
  void dispose() {
    appBloc.dispose();
    homeScreenBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle dropDownLabelStyle =
        TextStyle(color: Colors.white, fontSize: 16.0);

    const TextStyle dropDownMenuItemStyle =
        TextStyle(color: Colors.black, fontSize: 16.0);

    List<PopupMenuItem<int>> _buildPopupMenuItem(context) {
      final AppBloc appBloc = BlocProvider.of<AppBloc>(context);
      List<PopupMenuItem<int>> popupMenuItems = List();
      for (int i = 0; i < appBloc.locations.length; i++) {
        popupMenuItems.add(PopupMenuItem(
          child: Text(
            appBloc.locations[i],
            style: dropDownMenuItemStyle,
          ),
          value: i,
        ));
      }

      return popupMenuItems;
    }

    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 400.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [appTheme.firstColor, appTheme.secondColor],
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                StreamBuilder(
                  stream: appBloc.locationsStream,
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 16.0,
                                ),
                                PopupMenuButton(
                                  onSelected: (index) {
                                    appBloc.addFromLocation
                                        .add(appBloc.locations[index]);
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      StreamBuilder(
                                        stream: appBloc.fromLocationStream,
                                        initialData: appBloc.locations[0],
                                        builder: (context, snapshot) {
                                          return Text(
                                            snapshot.data,
                                            style: dropDownLabelStyle,
                                          );
                                        },
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                  itemBuilder: (BuildContext context) =>
                                      _buildPopupMenuItem(context),
                                ),
                                Spacer(),
                                Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          );
                  },
                ),
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  'Where would you\nlike to go?',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    child: TextField(
                      onChanged: (text) {
                        appBloc.addToLocation.add(text);
                      },
                      style: dropDownMenuItemStyle,
                      cursorColor: themeData.primaryColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 14.0),
                        suffixIcon: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InheritedFlightListing(
                                            child: FlightListingScreen(),
                                          )));
                            },
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: StreamBuilder(
                        stream: homeScreenBloc.isFlightSelectedStream,
                        initialData: true,
                        builder: (context, snapshot) {
                          print('in flight - ${snapshot.data}');
                          return ChoiceChips(
                              Icons.flight_takeoff, "Flights", snapshot.data);
                        },
                      ),
                      onTap: () {
                        homeScreenBloc.updateFlightSelection(true);
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    InkWell(
                      child: StreamBuilder(
                        stream: homeScreenBloc.isFlightSelectedStream,
                        initialData: true,
                        builder: (context, snapshot) {
                          print('in hotel - ${!snapshot.data}');
                          return ChoiceChips(
                              Icons.hotel, "Hotels", !snapshot.data);
                        },
                      ),
                      onTap: () {
                        homeScreenBloc.updateFlightSelection(false);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
