import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/loginScreen.dart';
import 'package:shop_app/network/shared/sharedPreferences/cache.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../network/components/components.dart';
import '../../styles/colors/colors.dart';
class BoardingModel
{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.body,
    required this.title,
    required this.image});
}
class OnBoardingScreen extends StatelessWidget
{
   OnBoardingScreen({Key? key}) : super(key: key);

  var boardController=PageController();

  bool isLast=false;


  List <BoardingModel> boarding=
  [
    BoardingModel(
        body: 'On board 1 body',
        title: 'On board 1 title',
        image: 'assets/images/onboard.png'),
    BoardingModel(
        body: 'On board 2 body',
        title: 'On board 2 title',
        image: 'assets/images/onboard.png'),
    BoardingModel(
        body: 'On board 3 body',
        title: 'On board 3 title',
        image: 'assets/images/onboard.png')
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      actions: [
        defaultTextButton(text: 'Skip', function:()
        {
          CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
          {
            if(value)
              {
                navigateAndFinish(context, ShopLoginScreen());
              }
            }
          );

        } )
      ],
    ),
      body:Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children:
        [
          Expanded(child: PageView.builder(onPageChanged: (index)
          {
            if(index==boarding.length-1)
            {
              isLast=true;
            }
            else
            {
              isLast=false;
            }
          },
            physics: BouncingScrollPhysics(),
            controller: boardController,
            itemBuilder: (context,index)=>BuildOnBoardItem(boarding[index]),
            itemCount: boarding.length,)),
          SizedBox(height: 40.0,),
          Row(
            children: [
              SmoothPageIndicator(
                controller: boardController,
                count: boarding.length,
                effect:
                ScaleEffect(
                  dotHeight: 10.0,
                  dotWidth: 10.0,

                  spacing: 5.0,
                  dotColor: Colors.grey,
                  activeDotColor: defaultColor,

                ),
              ),
              Spacer(),
              FloatingActionButton(onPressed: ()
              {
                if(isLast)
                {
                  CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
                  {
                    if(value)
                      {
                        navigateAndFinish(context, ShopLoginScreen());
                      }

                  });

                }
                else
                {
                  boardController.nextPage(duration: Duration(milliseconds: 750),
                      curve: Curves.fastLinearToSlowEaseIn);
                }

              },
                child: Icon(Icons.arrow_forward_ios),)
            ],
          ),

        ]),
      ) ,);
  }

}
Widget BuildOnBoardItem(BoardingModel model)=>
    Column(crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Expanded(child: Image(
              image: AssetImage('${model.image}'))),

          Text('${model.title}',
            style:TextStyle(
              fontSize: 24.0,

            ),),
          SizedBox(height: 15.0,),
          Text('${model.body}',
            style:TextStyle(
              fontSize: 14.0,

            ),),
          SizedBox(height: 15.0,),


        ]);





