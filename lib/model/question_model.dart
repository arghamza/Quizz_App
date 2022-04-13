class QuestionModel {
  String? qid;
  String? Question;
  String? img;
  String? GoodAnswer;
  String? FirstAnswer;
  String? SecondAnswer;

  QuestionModel(
      {this.qid,
      this.Question,
      this.img,
      this.GoodAnswer,
      this.FirstAnswer,
      this.SecondAnswer});
  //data from server
  factory QuestionModel.fromMap(map) {
    return QuestionModel(
      qid: map['qid'],
      Question: map['Question'],
      img: map['img'],
      GoodAnswer: map['GoodAnswer'],
      FirstAnswer: map['FirstAnswer'],
      SecondAnswer: map['SecondAnswer'],
    );
  }
  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'qid': qid,
      'Question': Question,
      'img': img,
      'GoodAnswer': GoodAnswer,
      'FirstAnswer': FirstAnswer,
      'SecondAnswer': SecondAnswer,
    };
  }
}
