

import 'dart:math';

class Question {
  String question;
  List<String> answers;
  int correctAnswer;
  String type;

  Question(this.question, this.answers, this.correctAnswer, {this.type = 'email'});
}


class QuestionList {
  static final questions = <Question>[
    Question("john@sandandear.cu.uke \n \n" +
     "deer ser/madam,\n \n" +
     "we have bean noticising wierd, purchqases on your ackount.\n" +
    "if u wold, plese giv us all ur pesonil detalles.\n" +
    "we kan stop this wierd spri ov spendangs!\n" +
    "thankz, Sandendar", 
    [
      "Delete",
      "Give username and password",
      "Give all personal details"
    ],
    0),

    Question("John.Smith@Santander.co.uk\n\n Dear Sir/Madam,\n\n" + 
    "We noticed that you have been spending a lot on minor purchases, \n" + 
    "we would like to confirm that you have spent £55,627.31 on vending machines using your credit card. \n" + 
    "Get back to us with any further actions you would like to take, Santander",
    [
      "Ignore",
      "Freeze credit card and contact bank"
    ],1), 
    Question("To login to your google account,\n" + 
    "please give your password",
    [
      "Give username",
      "Report to the police",
      "Give Password"
    ],
    2 , type:'situation'),
    Question(
      "You have recieved a package in your name you didn't order,\n What do you do?",
      [
        "Tell the company you didn't order it and return it",
        "Return it and pretend nothing happened",
        "Don't do anything and enjoy your new thing"
      ],0,type:'situation'
    ),
    Question(
      "Best_Investment@Investinme.com\n\n Dear Sir/Madam,\n\n" + 
      "We want to talk to you about our amazing company.\n " + 
      "You can invest in it and you might earn up to £10,000,\n " +
      "all you have to do is give me your bank details and give me some money,\n " + 
      "you might earn as much as 10 times as much as you invest.\n" + 
      "Thank you for this, Invest in Me!",
      [
        "Give bank details",
        "Give bank details and £1000",
        "Delete"
        ],2
    ),
    Question("You are throwing away mail, what do you do",
    [
      "Just throw it away",
      "Shread it",
      "Rip off your address"
    ]
      ,1, type:'situation'),
  ];

  static Question randomQuestion() {
    return questions[ Random().nextInt(questions.length) ];
  }
}