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
            String status = '';
            String animationPath = '';
            String pingStatus = '';
            Color color = Colors.grey;

            if (state is NetworkLoading) {
              status = 'Checking Network...';
              animationPath = 'assets/searching.json';
              color = Colors.grey;
            } else if (state is NetworkConnected) {
              if (state.connectionType == 'WiFi') {
                status = 'Connected to ${state.connectionType}';
                animationPath = 'assets/WiFi.json';
                color = Colors.blue;
              } else {
                status = 'Connected to ${state.connectionType}';
                animationPath = 'assets/data_signal.json';
                color = Colors.green;
              }
              pingStatus =
                  state.hasInternet
                      ? 'Internet is Available'
                      : 'No Internet Access';
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
                    textStyle: TextStyle(
                      fontSize: 24,
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
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
