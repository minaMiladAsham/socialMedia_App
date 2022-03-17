import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmediaapp/modules/home_screen/home_layout_cubit/home_layout_cubit.dart';
import 'package:socialmediaapp/modules/home_screen/home_layout_cubit/home_layout_states.dart';
import 'package:socialmediaapp/shared/constants/constants.dart';


class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Add Post'),
              actions: [
                TextButton(
                    onPressed: () {
                      if (HomeLayoutCubit.get(context).postImage == null) {
                        HomeLayoutCubit.get(context).createPost(
                            text: textController.text,
                            dateTime: now.toString());
                            HomeLayoutCubit.get(context).getPosts();
                      } else {
                        HomeLayoutCubit.get(context).uploadPostImage(
                            text: textController.text,
                            dateTime: now.toString());
                        HomeLayoutCubit.get(context).getPosts();
                      }
                    },
                    child: Text('Post')),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if ( state is HomeLoadingUploadPostImage || state is HomeLoadingCreatePost)
                    LinearProgressIndicator(),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            '${HomeLayoutCubit.get(context).model!.profileImage}'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${HomeLayoutCubit.get(context).model!.name}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            '${now}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: Text('Write what in ypur mind........'),
                      ),
                      keyboardType: TextInputType.text,
                      controller: textController,
                    ),
                  ),
                  if (HomeLayoutCubit.get(context).postImage != null)
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Align(
                          child: Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4.0),
                                  topLeft: Radius.circular(4.0)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(
                                      HomeLayoutCubit.get(context).postImage!)),
                            ),
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              HomeLayoutCubit.get(context).removePostImage();
                            },
                            child: CircleAvatar(
                              backgroundColor: defaultColor,
                              radius: 20,
                              child: Icon(Icons.close , color: Colors.white,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                HomeLayoutCubit.get(context).getPostImage();
                              }, child: Text('Add Image'))),
                      Expanded(
                          child: TextButton(
                              onPressed: () {}, child: Text('Add Tags'))),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
