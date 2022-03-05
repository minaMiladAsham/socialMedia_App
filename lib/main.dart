import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmediaapp/modules/home_screen/home_layout_cubit/home_layout_cubit.dart';
import 'package:socialmediaapp/shared/bloc_observer/bloc_observer.dart';
import 'package:socialmediaapp/shared/cache_helper/cache_helper.dart';
import 'package:socialmediaapp/shared/constants/constants.dart';

import 'modules/home_screen/home_layout_cubit/home_layout_states.dart';
import 'modules/home_screen/home_screen.dart';
import 'modules/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await cacheHelper.init();
  uId = cacheHelper.getData(key: 'uIdkey');
  print(uId);
  Widget startWidget;
  if (uId != null){
    startWidget = HomeScreen();
  }else startWidget = LoginScreen();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp(startWidget: startWidget,));
}

class MyApp extends StatelessWidget {
final Widget startWidget;
MyApp ({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeLayoutCubit()..getUserData(),
      child: BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        listener: (context,state){},
        builder: (context,State){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
            theme: lightTheme,
          );
        },
      ),
    );
  }
}



