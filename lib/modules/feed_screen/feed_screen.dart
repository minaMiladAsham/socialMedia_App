import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmediaapp/modules/home_screen/home_layout_cubit/home_layout_cubit.dart';
import 'package:socialmediaapp/shared/constants/constants.dart';

import '../home_screen/home_layout_cubit/home_layout_states.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>
      (
      listener: (context , state){},
      builder: (context,state){
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
           children: [
             Card(
               child: Stack(
                 alignment: AlignmentDirectional.topEnd,
                 children: [
                   Image(
                     image: NetworkImage('https://www.incimages.com/uploaded_files/image/1920x1080/getty_624206636_200013332000928034_376810.jpg'),
                     width: double.infinity,
                     height: 200,
                     fit: BoxFit.cover,
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Text('add FUN to your life' , style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.black), ),
                   ),
                 ],
               ),
               clipBehavior: Clip.antiAliasWithSaveLayer,
               elevation: 10.0,
               margin: EdgeInsets.all(8),
             ),
             ListView.separated(
               shrinkWrap: true,
                 physics: NeverScrollableScrollPhysics(),
                 itemBuilder: (context,index)=>feedBackItemDesign(context),
                 separatorBuilder: (context , index) => SizedBox(height: 1,),
                 itemCount: 10),
           ],
          ),
        );
      },
    );
  }

  Widget feedBackItemDesign (context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Card(
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm5GlFAeYd8jgwc8dA7Z_3wPu9u4IcE1dCOg&usqp=CAU'),
                      ),


                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Mina Milad' , style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),),
                              SizedBox(width: 5,),
                              Icon(Icons.check_circle_rounded , color: defaultColor,size: 15,),
                            ],
                          ),
                          SizedBox(height: 3,),
                          Text('Febrauary 20,2022 at 07:40' , style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.more_horiz, color: Colors.black,),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10 ,vertical: 5),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry.'
                      ' Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,'
                      ' when an unknown printer took a galley of type and scrambled it to make a type specimen book.' ,
                    maxLines: 5,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(overflow: TextOverflow.ellipsis,height: 1.2),
                  ),
                  Container(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 0.0,
                      children: [
                        Container(
                          height: 30,
                          child: MaterialButton(
                            onPressed: (){},
                            padding: EdgeInsets.zero,
                            minWidth: 0.1,
                            child: Text('#gym',style: TextStyle(color: Colors.blueAccent),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: double.infinity,
                    child: Image(
                      image: NetworkImage('https://i.pinimg.com/originals/59/6e/0f/596e0faa2c648762ceff576bc7a36270.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Row(
                          children: [
                            Icon(Icons.check , color: defaultColor,),
                            SizedBox(width: 5,),
                            Text('120' , style: Theme.of(context).textTheme.caption,)
                          ],
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: (){},
                        child: Row(
                          children: [
                            Icon(Icons.messenger_outline , color: defaultColor,),
                            SizedBox(width: 5,),
                            Text('120 Comments' , style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10 ,vertical: 5),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm5GlFAeYd8jgwc8dA7Z_3wPu9u4IcE1dCOg&usqp=CAU'),
                      ),
                      SizedBox(width: 10,),
                      Container(
                          height: 25,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),

                          child: Center(child: Text('Write a Comment.....' , style: Theme.of(context).textTheme.caption,))),
                      Spacer(),
                      InkWell(
                        onTap: (){},
                        child: Row(
                          children: [
                            Icon(Icons.ios_share , color: Colors.green,),
                            SizedBox(width: 5,),
                            Text('Share' , style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
