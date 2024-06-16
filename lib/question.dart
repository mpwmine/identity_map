

import 'dart:math';

class Question {
  String question;
  List<String> answers;
  int correctAnswer;

  Question(this.question, this.answers, this.correctAnswer);
}


class QuestionList {
  static final questions = <Question>[
    Question("john@sandandear.cu.uke deer ser/madam,\n we have bean noticising wierd, purchqases on your ackount.\n if u wold, plese giv us all ur pesonil detalles.\n we kan stop this wierd spri ov spendangs! thankz, Sandendar", ["Ignore","Give username and password","Give all personal details"],0),
    Question("John.Smith@Santander.co.uk Dear Sir/Madam,\n We noticed that you have been spending a lot on minor purchases, we would like to confirm that you have spent £55,627.31 on vending machines using your credit card. Get back to us with any further actions you would like to take, Santander",["Ignore","Shut down credit card"],1), 
    Question("To login to your google account,\n please give your password",["Give username","Report to the police","Give Password"],2),
    Question("You have recieved a package in your name you didn't order,\n What do you do?",["Tell the company you didn't order it and return it","Return it and pretend nothing happened","Don't do anything and enjoy your new thing"],0),
    Question("Best_Investment@Investinme.com Dear Sir/Madam,\n We want to talk to you about our amazing company. You can invest in it and you might earn up to £10,000, all you have to do is give me your bank details and give me some money, you might earn as much as 10 times as much as you invest. Thank you for this, Invest in Me!",["Give bank details", "Give bank details and £1000", "Ignore"],2),
    Question("You are throwing away mail, what do you do",["Just throw it away", "Shread it", "Rip off your address"],1),
  ];

  static Question randomQuestion() {
    return questions[ Random().nextInt(questions.length) ];
  }
}