import 'package:flutter/material.dart';
import 'package:masairline/bloc/app_bloc.dart';
import 'package:masairline/bloc/bloc_provider.dart';
import 'package:masairline/screens/Home/home_bottom_part.dart';
import 'package:masairline/screens/Home/home_top_part.dart';
import 'package:masairline/widgets/style/CustomAppBottomBar.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppBloc appBloc;
  @override
  void initState(){
    super.initState();
    appBloc = BlocProvider.of<AppBloc>(context);
  }

  Widget build(BuildContext context) {
   return Scaffold(
      bottomNavigationBar: CustomAppBottomBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            HomeScreenTopPart(),
            HomeScreenBottomPart(),
          ],
        ),
      ),
    );
  }
}