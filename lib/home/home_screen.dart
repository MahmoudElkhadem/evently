import 'package:evently/home/taps/favorite/favorite_tab.dart';
import 'package:evently/home/taps/home_tab/home_tab.dart';
import 'package:evently/home/taps/profile/profile_tap.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/utils/app_color.dart';
import 'package:evently/utils/app_route.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;

  List<Widget> tabList = [
    HomeTab(),
    FavoriteTab(),
    ProfileTap()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: tabList[selectedIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.pushNamed(context, AppRoute.addEventScreen);
          },
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: AppColor.inputsLightMode,
          shape: StadiumBorder(
            side: BorderSide(
              color: Theme.of(context).primaryColor,
            )
          ),
          child: Icon(Icons.add),
        ),
        bottomNavigationBar:  BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
            selectedIndex = index;
            setState(() {
            });
          },
        items: [
          _buildButtonNavBarItem(
              selectedIcon: Icon(Icons.home),
              unSelectedIcon: Icon(Icons.home_outlined),
              isSelected: selectedIndex == 0,
              lable: AppLocalizations.of(context)!.home),
          _buildButtonNavBarItem(
              selectedIcon: Icon(Icons.favorite),
              unSelectedIcon: Icon(Icons.favorite_border),
              isSelected: selectedIndex == 1,
              lable: AppLocalizations.of(context)!.favorite),
          _buildButtonNavBarItem(
              selectedIcon: Icon(Icons.person),
              unSelectedIcon: Icon(Icons.person_outline),
              isSelected: selectedIndex == 2,
              lable: AppLocalizations.of(context)!.profile)
        ],
        )
    );
  }


  BottomNavigationBarItem _buildButtonNavBarItem(
  {
    required Widget selectedIcon,
    required Widget unSelectedIcon,
    required bool isSelected,
    required String lable,
  }
      )
  {
    return BottomNavigationBarItem(
        icon: isSelected ? selectedIcon : unSelectedIcon,
      label: lable
    );
}
}
