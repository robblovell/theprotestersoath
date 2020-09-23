import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:theprotestersoath/navigation/app_drawer/appdrawer_bloc.dart';
import 'package:theprotestersoath/navigation/app_drawer/appdrawer_event.dart';
import 'package:theprotestersoath/oath/OathContainer.dart';
import 'OathContainer.dart';

class OathPage extends StatelessWidget {
  // static Route route() {
  //   return MaterialPageRoute(builder: (_) => OathPage());
  // }

  @override
  Widget build(BuildContext context) {
    // void _showErrorSnackBar() {
    //   Scaffold.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text('Oops... the URL couldn\'t be opened!'),
    //     ),
    //   );
    // }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "THEOATH".tr(),
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.art_track, size: 40),
              onPressed: () =>
                  BlocProvider.of<AppDrawerBloc>(context).add(StoryPageEvent()),
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.turned_in),
            onPressed: () {
              BlocProvider.of<AppDrawerBloc>(context)
                  .add(BackButtonEvent("OathPage"));
            },
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        // A flexible child that will grow to fit the viewport but
                        // still be at least as big as necessary to fit its contents.
                        child: Container(
                          color: Colors.grey[100],
                          height: 18.0,
                          alignment: Alignment.center,
                          child: TheOath(false, viewportConstraints),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
