import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmediaapp/modules/home_screen/home_layout_cubit/home_layout_cubit.dart';
import '../../models/save_data_in_firebase/save_data_in_firebase_model.dart';
import '../chat_details_screen/chat_details_screen.dart';
import '../home_screen/home_layout_cubit/home_layout_states.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>
      (
      listener: (context , state){},
      builder: (context,state){
       return ConditionalBuilder(
           condition:  HomeLayoutCubit.get(context).users.length > 0,
           builder: (context) => ListView.separated(
               itemBuilder: (context , index) =>  chatItem(HomeLayoutCubit.get(context).users[index], context),
               separatorBuilder: (context , index) => Container( height: 1, color: Colors.grey[300],),
               itemCount: HomeLayoutCubit.get(context).users.length),
           fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }


  Widget chatItem(saveDataInFirebaseModel model , context) {
    return InkWell(
      onTap: (){
        ChatDetailsScreen(model);
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('${model.profileImage}'),
          ),
          Text('${model.name}' , style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.black),),
        ],
      ),
    );
  }
}
