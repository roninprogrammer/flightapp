
import 'package:flutter/material.dart';
import 'package:masairline/bloc/bloc_provider.dart';
import 'package:masairline/screens/Home/home.dart';
import 'package:masairline/util/util.dart';

import 'bloc/app_bloc.dart';
import 'bloc/home_screen_bloc.dart';

void main(){
  runApp(BlocProvider(
    bloc: AppBloc(),
    child: MaterialApp(
      title: Util.app_name,
      debugShowCheckedModeBanner: false,
  home: BlocProvider(
    bloc: HomeScreenBloc(),
    child: HomeScreen(),
  ),
  theme: themeData,
    ),
    
  ));
}

ThemeData themeData =
    ThemeData(primaryColor: Color(0xFFF3791A), fontFamily: 'Oxygen');


  Color firstColor = Color(0xFFF47D15);
  Color secondColor = Color(0xFFEF772C);