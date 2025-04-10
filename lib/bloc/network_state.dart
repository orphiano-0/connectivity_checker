abstract class NetworkState {}

class NetworkInitial extends NetworkState {}

class NetworkConnected extends NetworkState {
  final String connectionType;
  final bool hasInternet;

  NetworkConnected({required this.connectionType, required this.hasInternet});
}

class NetworkDisconnected extends NetworkState {}