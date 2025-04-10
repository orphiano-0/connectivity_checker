import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkEvent {}

class NetworkChanged extends NetworkEvent {
  final ConnectivityResult result;

  NetworkChanged(this.result);
}