import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

import 'network_event.dart';
import 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  final Connectivity _connectivity;
  late StreamSubscription _connectivitySubscription;

  NetworkBloc(this._connectivity) : super(NetworkInitial()) {
    on<NetworkChanged>(_onNetworkChanged);

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      result,
    ) {
      if (result.isNotEmpty) {
        add(NetworkChanged(result.first));
      }
    });
  }

  Future<void> _onNetworkChanged(NetworkChanged event, Emitter<NetworkState> emit) async {
    bool hasInternet = await _checkInternetAccess();
    switch (event.result) {
      case ConnectivityResult.wifi:
        emit(NetworkConnected(connectionType: 'WiFi', hasInternet: hasInternet));

        break;
      case ConnectivityResult.mobile:
        emit(NetworkConnected(connectionType: 'Mobile Data', hasInternet: hasInternet));
        print(ConnectivityResult.mobile);
        break;
      case ConnectivityResult.none:
        emit(NetworkDisconnected());
        break;
      default:
        emit(NetworkDisconnected());
        break;
    }
  }

  Future<bool> _checkInternetAccess() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com')).timeout(
        const Duration(seconds: 5)
      );
      return result.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
