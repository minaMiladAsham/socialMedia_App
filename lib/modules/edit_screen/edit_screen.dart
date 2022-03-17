import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmediaapp/modules/home_screen/home_layout_cubit/home_layout_states.dart';
import 'package:socialmediaapp/shared/components/components.dart';
import 'package:socialmediaapp/shared/constants/constants.dart';
import '../home_screen/home_layout_cubit/home_layout_cubit.dart';

class EditProfilrScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var model = HomeLayoutCubit.get(context).model;
    var profileImage = HomeLayoutCubit.get(context).profileImage;
    var coverImage = HomeLayoutCubit.get(context).coverImage;
    nameController.text = model!.name!;
    bioController.text = model.bio!;
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
            actions: [
              TextButton(
                onPressed: () {
                  HomeLayoutCubit.get(context).updateUserDate(name: nameController.text, bio: bioController.text);
                },
                child: Text(
                  'Update',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: defaultColor),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if(state is HomeLoadingUpdateUserData)
                    LinearProgressIndicator(),
                SizedBox(height: 10,),
                Container(
                  height: 220,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 180,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(4.0),
                                    topLeft: Radius.circular(4.0)),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: coverImage == null
                                      ? NetworkImage(
                                          '${model.coverImage}')
                                      : FileImage(coverImage) as ImageProvider,


                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: defaultColor,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    HomeLayoutCubit.get(context)
                                        .getCoverImage();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            radius: 53,
                            child: CircleAvatar(
                                radius: 50,
                                backgroundImage: profileImage != null
                                    ? FileImage(profileImage)
                                    : NetworkImage('${model.profileImage!}')
                                        as ImageProvider),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: defaultColor,
                            child: IconButton(
                              icon: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                HomeLayoutCubit.get(context).getProfileImage();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
               // if(HomeLayoutCubit.get(context).profileImage != null || HomeLayoutCubit.get(context).profileImage != null )
                  Row(
                    children: [
                     // if(HomeLayoutCubit.get(context).coverImage != null)
                        Expanded(
                          child: OutlinedButton(onPressed: (){
                            HomeLayoutCubit.get(context).uploadCovermage(name: nameController.text , bio: bioController.text);
                          }, child: Text('Upload Cover')),
                        ),
                      SizedBox(width: 10,),
                     // if(HomeLayoutCubit.get(context).profileImage != null)
                        Expanded(
                          child: OutlinedButton(onPressed: (){
                            HomeLayoutCubit.get(context).uploadProfileImage(name: nameController.text , bio: bioController.text);
                          }, child: Text('Upload Profile')),
                        ),


                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                defaultTextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  text: 'Name',
                  prefix: Icons.edit,
                ),
                SizedBox(
                  height: 10,
                ),
                defaultTextFormField(
                  controller: bioController,
                  keyboardType: TextInputType.text,
                  text: 'Bio',
                  prefix: Icons.edit,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
