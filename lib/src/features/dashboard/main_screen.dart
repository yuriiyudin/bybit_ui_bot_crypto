import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:terminal_octopus/src/constants/theme.dart';
import 'package:terminal_octopus/src/features/dashboard/live_board/view/dashboard_screen.dart';
import 'package:terminal_octopus/src/features/dashboard/widgets/cover_widget.dart';

import 'package:terminal_octopus/src/features/dashboard/widgets/drawe_button_widget.dart';
import 'package:terminal_octopus/src/features/dashboard/widgets/main_logo_widget.dart';
import 'package:terminal_octopus/src/routes/named_route.dart';




class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashBoardState();
}

class _DashBoardState extends ConsumerState<HomeScreen> {
     bool show = false;
  
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      onDrawerChanged: (isOpened) {
      setState(() {
         show = !show;
      });
      },

        drawerScrimColor: Colors.transparent,
        appBar: AppBar(),
        backgroundColor: kDefaultbackgroundColor,
        drawer: Drawer(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
          ),
          backgroundColor: Colors.transparent,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 35, bottom: 10),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: MainLogoWidget(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 33),
                child: Divider(
                  thickness: 0.3,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 130),
                child: MenuButton(
                  title: 'Dashboard',
                  icon: Icons.dvr,
                  location: MyAppRouteConstants.homeRouteName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 155),
                child: MenuButton(
                  title: 'History',
                  icon: Icons.history,
                  location: MyAppRouteConstants.history,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 155),
                child: MenuButton(
                  title: 'Signals',
                  icon: Icons.wifi_outlined,
                  location: MyAppRouteConstants.signals,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 155),
                child: MenuButton(
                  title: 'Wallet',
                  icon: Icons.wallet_outlined,
                  location: MyAppRouteConstants.signals,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 155),
                child: MenuButton(
                  title: 'Settings',
                  icon: Icons.settings_outlined,
                  location: MyAppRouteConstants.signals,
                ),
              ),
            ],
          ),
        ),
        body: show ? CoverWidget() :  CoverWidget(child: DashBoardScreen()));
  }
}
