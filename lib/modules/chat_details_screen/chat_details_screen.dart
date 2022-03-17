import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmediaapp/models/chat_model/chat_model.dart';
import 'package:socialmediaapp/models/save_data_in_firebase/save_data_in_firebase_model.dart';
import 'package:socialmediaapp/modules/home_screen/home_layout_cubit/home_layout_cubit.dart';
import 'package:socialmediaapp/modules/home_screen/home_layout_cubit/home_layout_states.dart';
import 'package:socialmediaapp/shared/constants/constants.dart';

class ChatDetailsScreen extends StatelessWidget {

  saveDataInFirebaseModel userModel;
  ChatDetailsScreen(this.userModel);

  var messageTextController = TextEditingController();
  var now = DateTime.now;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        HomeLayoutCubit.get(context).getMessages(receiverId: userModel.uId);
        return BlocConsumer<HomeLayoutCubit , HomeLayoutStates>(
          listener: (context , state) {},
          builder: (context , state) {
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage('${userModel.profileImage}'),
                    ),
                    SizedBox(width: 10,),
                    Text('${userModel.name}'),
                  ],
                ),
              ),

              body: ConditionalBuilder(
                condition: HomeLayoutCubit.get(context).messages.length > 0,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ListView.separated(
                          itemBuilder: (context , index) {
                                var messages = HomeLayoutCubit.get(context).messages[index];
                                if(HomeLayoutCubit.get(context).model!.uId == messages.senderId)
                                  return buildSenderItem(messages);
                                else return buildReceiverItem(messages);
                          },
                          separatorBuilder: (context , index) => SizedBox(height: 5,),
                          itemCount: HomeLayoutCubit.get(context).messages.length),
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                          ),
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              color: defaultColor,
                              child: MaterialButton(
                                onPressed: (){
                                  HomeLayoutCubit.get(context).sendMessage(
                                      receiverId: userModel.uId,
                                      dateTime: now.toString(),
                                      text: messageTextController.text);
                                },
                                child: Icon(Icons.send,size: 16,color: Colors.white,),
                              ),
                            ),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
                fallback: (context) => Center(child: CircularProgressIndicator()),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildSenderItem(ChatModel model){
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          color: Colors.grey[300],

        ),
        child: Text('${model.text}'),
      ),
    );
  }

  Widget buildReceiverItem(ChatModel model){
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          color: defaultColor.withOpacity(0.2),
        ),
        child: Text('${model.text}'),
      ),
    );
  }
}
