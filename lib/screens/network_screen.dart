import 'dart:io';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:network_connectivity_checker/bloc/network_bloc.dart';
import 'package:network_connectivity_checker/bloc/network_state.dart';
import 'package:google_fonts/google_fonts.dart';

class NetworkScreen extends StatelessWidget {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Network Connectivity Checker',
          style: GoogleFonts.workSans(
            textStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, state) {
            String status = 'Network Checking...';
            String animationPath = 'assets/searching.json';
            String pingStatus = 'Checking Internet Connection...';
            Color color = Colors.grey;

            if (state is NetworkConnected) {
              // change based on the connection type
              // status = 'Connected to ${state.connectionType == 'WiFi' ? 'WiFi' : 'Mobile Data'}';
              // animationPath = state.connectionType == 'WiFi' ? 'assets/WiFi.json' : 'assets/data_signal.json';
              // color = state.connectionType == 'WiFi' ? Colors.blue : Colors.green;
              if (state.connectionType == 'WiFi') {
                status = 'Connected to ${state.connectionType}';
                animationPath = 'assets/WiFi.json';
                color = Colors.blue;
              } else {
                status = 'Connected to ${state.connectionType}';
                animationPath = 'assets/data_signal.json';
                color = Colors.green;
              }

              // print(state.connectionType);
              pingStatus = state.hasInternet ? 'Internet is Available' : 'No Internet Access';
              print(state.hasInternet);
            } else if (state is NetworkDisconnected) {
              status = 'No Internet Connection';
              animationPath = 'assets/no_connection.json';
              color = Colors.red;
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  width: 250,
                  child: Lottie.asset(animationPath, fit: BoxFit.contain),
                ),
                Text(
                  status,
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(fontSize: 24, color: color, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  pingStatus,
                  style: GoogleFonts.workSans(
                    textStyle: TextStyle(fontSize: 24, color: color),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
