import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:socialmediaapp/modules/edit_screen/edit_screen.dart';
import 'package:socialmediaapp/modules/home_screen/home_layout_cubit/home_layout_cubit.dart';
import 'package:socialmediaapp/shared/cache_helper/cache_helper.dart';
import 'package:socialmediaapp/shared/constants/constants.dart';
import '../../shared/components/components.dart';
import '../home_screen/home_layout_cubit/home_layout_states.dart';
import '../login/login_screen.dart';

class SettingsScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeLayoutCubit.get(context).model;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 220,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topRight: Radius.circular(4.0), topLeft: Radius.circular(4.0)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${model!.coverImage}')),
                            ),
                          ),
                        alignment: AlignmentDirectional.topCenter,
                      ),

                      CircleAvatar(
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        radius: 53,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage('${model.profileImage}'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Text('${model.name}' , style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.black),),
                SizedBox(height: 5,),
                Text('${model.bio}' , style: Theme.of(context).textTheme.caption,),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('Posts' , style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),),
                          SizedBox(height: 5,),
                          Text('25' , style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Likes' , style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),),
                          SizedBox(height: 5,),
                          Text('10K' , style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Followers' , style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),),
                          SizedBox(height: 5,),
                          Text('425' , style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Images' , style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),),
                          SizedBox(height: 5,),
                          Text('538' , style: Theme.of(context).textTheme.bodyText1,),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
          floatingActionButton: SpeedDial(
            backgroundColor: defaultColor,
            spacing: 20,
            animatedIcon: AnimatedIcons.arrow_menu,
            children: [
              SpeedDialChild(
                onTap: (){
                  navigateTo(context, EditProfilrScreen());
                },
                child: Icon(Icons.edit),
                label: 'Edit Profile'
              ),
              SpeedDialChild(
                  onTap: (){
                    cacheHelper.remove('uIdkey');
                    navigateTo(context, LoginScreen());
                  },
                  child: Icon(Icons.logout),
                  label: 'Logout'
              ),
            ],
          ),
        );
      },
    );
  }
}
