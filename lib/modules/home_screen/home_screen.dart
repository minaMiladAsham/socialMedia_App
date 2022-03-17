import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmediaapp/modules/home_screen/home_layout_cubit/home_layout_cubit.dart';
import 'package:socialmediaapp/modules/home_screen/home_layout_cubit/home_layout_states.dart';
import 'package:socialmediaapp/shared/components/components.dart';
import '../new_post_screen/new_post_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {
        if (state is HomeAddPost){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              MaterialButton(
                onPressed: () {},
                padding: EdgeInsets.zero,
                child:IconButton(
                  onPressed: () {  },
                  icon: Icon(Icons.search),
                ),
              ),
              MaterialButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child:IconButton(
                  onPressed: () {  },
                  icon: Icon(Icons.notifications_active_outlined),
                ),
              ),
              // MaterialButton(
              //   padding: EdgeInsets.zero,
              //   onPressed: () {},
              //   child:IconButton(
              //     onPressed: () {
              //       cacheHelper.remove('uIdkey');
              //       navigateTo(context, LoginScreen());
              //     },
              //     icon: Icon(Icons.logout),
              //   ),
              // ),
            ],
            title: Text(
                HomeLayoutCubit.get(context).titles[HomeLayoutCubit.get(context).currentIndex],
            ),
          ),
          body: HomeLayoutCubit.get(context).screens[HomeLayoutCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.message_sharp,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.upload_file,
                ),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.location_on_sharp,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
            currentIndex: HomeLayoutCubit.get(context).currentIndex,
            onTap: (index){
              HomeLayoutCubit.get(context).changeBottomNavBar(index);
            },
          ),
        );
      },
    );
  }
}
