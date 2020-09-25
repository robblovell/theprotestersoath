import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theprotestersoath/authentication/authentication.dart';
import 'package:theprotestersoath/navigation/app_drawer/appdrawer_bloc.dart';
import 'package:theprotestersoath/navigation/app_drawer/appdrawer_event.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:theprotestersoath/oath/OathCard.dart';
import 'package:theprotestersoath/utils/sizing.dart';

class TheOath extends StatelessWidget {
  TheOath(this.isLogin, this.viewportConstraints);

  bool isLogin = false;
  BoxConstraints viewportConstraints = BoxConstraints();

  // App Bar for the Login/Oath.
  @override
  Widget build(BuildContext context) {
    // double appBarHeight = screenHeight(context) < 600 ? 75 : 75;

    return CustomScrollView(shrinkWrap: false, slivers: <Widget>[
      SliverAppBar(
        pinned: true,
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_back, size: 40),
              onPressed: () {
                if (this.isLogin) {
                  BlocProvider.of<AuthenticationBloc>(context)
                      .add(LoginReasonPageEvent());
                } else {
                  BlocProvider.of<AppDrawerBloc>(context)
                      .add(ReasonPageEvent());
                }
              }),
        ],
        // expandedHeight: appBarHeight,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.zero,
          centerTitle: false,
          title: Text("LOGIN_TITLE".tr()),
        ),
      ),
      TheOathGrid(isLogin, this.viewportConstraints)
    ]);
  }
}

class TheOathGrid extends StatelessWidget {
  TheOathGrid(this.isLogin, this.viewportConstraints);

  bool isLogin = false;
  BoxConstraints viewportConstraints;

  @override
  Widget build(BuildContext context) {
    final double height = screenHeight(context);
    var viewportHeight = this.viewportConstraints.maxHeight;
    var viewportWidth = this.viewportConstraints.maxWidth;
    var paddingTopScreen = MediaQuery.of(context).padding.top;
    var paddingLeftScreen = MediaQuery.of(context).padding.left;
    var paddingRightScreen = MediaQuery.of(context).padding.right;
    var appBarHeight = AppBar().preferredSize.height;
    var loginButtonSpace = isLogin ? 170 : 0;

    var availableHeightBig =
        height - (appBarHeight + paddingTopScreen) - loginButtonSpace;
    var availableHeightSmall =
        viewportHeight - (appBarHeight + paddingTopScreen) - loginButtonSpace;
    var availableWidth = viewportWidth - paddingLeftScreen + paddingRightScreen;

    // Height of the Title Card above and the Number Entry card and the spacing between elements
    var cardPadding = 0.0;
    var cardHeightBig = (availableHeightBig - (cardPadding * 9)) / 9;
    var cardHeightSmall = (availableHeightSmall - (cardPadding * 9)) / 9;
    if (cardHeightSmall < 18) cardHeightSmall = 18;
    var cardHeight = cardHeightBig;

    if (viewportHeight != height) {
      cardHeight = cardHeightSmall;
      // if (cardHeight < 15) {cardHeight = cardHeightBig;}
    }

    var cardWidth = availableWidth + cardPadding * 2;
    var aspect = cardWidth / cardHeight;

    print("Container::Height: " + height.toString());
    print("Container::viewportHeight: " + viewportHeight.toString());
    // print("Container::paddingTopScreen: " + paddingTopScreen.toString());
    // print("Container::paddingLeftScreen: " + paddingLeftScreen.toString());
    // print("Container::paddingRightScreen: " + paddingRightScreen.toString());
    // print("Container::appBarHeight: " + appBarHeight.toString());
    // print("Container::loginButtonSpace: " + loginButtonSpace.toString());
    // print("Container::availableHeightBig: " + availableHeightBig.toString());
    // print("Container::availableHeightSmall: " + availableHeightSmall.toString());
    print("Container::cardHeightBig: " + cardHeightBig.toString());
    print("Container::cardHeightSmall: " + cardHeightSmall.toString());
    // print("Container::cardHeight: " + cardHeight.toString());
    // print("Container::cardWidth: " + cardWidth.toString());
    // print("Container::cardAspect: " + aspect.toString());

    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: cardPadding,
        crossAxisSpacing: cardPadding,
        childAspectRatio: aspect, // between 7 and 9.
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.centerLeft,
            color: Colors.grey[300 + index % 2 * 100],
            child: (viewportHeight != height && viewportHeight < 600)
                ? OathCard('SHORT_POINT_0$index', isLogin, index)
                : OathCard('POINT_0$index', isLogin, index),
          );
        },
        childCount: 9,
      ),
    );
  }
}
