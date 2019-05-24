import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masairline/bloc/app_bloc.dart';
import 'package:masairline/bloc/bloc_provider.dart';
import 'package:masairline/data/city.dart';
import 'package:masairline/main.dart';
import 'package:masairline/screens/City/index.dart';

class HomeScreenBottomPart extends StatefulWidget {
  @override
  _HomeScreenBottomPartState createState() => _HomeScreenBottomPartState();
}

class _HomeScreenBottomPartState extends State<HomeScreenBottomPart> {
  AppBloc appBloc;
 

  @override
  void initState() {
    super.initState();
    appBloc = BlocProvider.of<AppBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Currently Watched Items",
                style: dropDownMenuItemStyle,
              ),
              Spacer(),
              StreamBuilder(
                stream: appBloc.citiesCounterStream,
                builder: (context, snapshot) {
                  return Text(
                    "VIEW ALL(${snapshot.data})",
                    style: viewAllStyle,
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          height: 240.0,
          child: StreamBuilder(
              stream: appBloc.citiesSnapshotStream,
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Center(child: CircularProgressIndicator())
                    : _buildCitiesList(context, snapshot.data.documents);
              }),
        ),
      ],
    );
  }

  Widget _buildCitiesList(
      BuildContext context, List<DocumentSnapshot> snapshots) {
    return ListView.builder(
        itemCount: snapshots.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CityCard(city: City.fromSnapshot(snapshots[index]));
        });
  }

  TextStyle dropDownMenuItemStyle =
      TextStyle(color: Colors.black, fontSize: 16.0);
  var viewAllStyle = TextStyle(fontSize: 14.0, color: themeData.primaryColor);
}
