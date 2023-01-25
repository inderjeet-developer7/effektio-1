class SessionInfoModel {
  SessionInfoModel(
    this.isCurrent,
    this.name,
    this.sessionID,
    this.address,
    this.isOnline,
    this.lastSeen,
  );

  final bool isCurrent;
  final String name;
  final String sessionID;
  final String address;
  final bool isOnline;
  final String lastSeen;
}
