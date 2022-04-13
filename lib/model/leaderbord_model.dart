class LeaderBoardModel {
  String? uid;
  String? FirstName;
  int? Score;

  LeaderBoardModel({this.uid, this.FirstName, this.Score});
  //data from server
  factory LeaderBoardModel.fromMap(map) {
    return LeaderBoardModel(
        uid: map['uid'], FirstName: map['FirstName'], Score: map['Score']);
  }
  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'FirstName': FirstName,
      'Score': Score,
    };
  }
}
