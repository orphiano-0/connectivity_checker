import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:network_connectivity_checker/bloc/network_bloc.dart';
import 'package:network_connectivity_checker/screens/network_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Connectivity _connectivity = Connectivity();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NetworkBloc(_connectivity),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: NetworkScreen(),
      ),
    );
  }
}
