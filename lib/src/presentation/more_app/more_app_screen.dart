import 'package:flutter/material.dart';
import 'package:hues_dovui/src/presentation/base/base_widget.dart';
import 'package:hues_dovui/src/presentation/home/home_screen.dart';
import 'package:hues_dovui/src/presentation/more_app/moreapp_viewmodel.dart';
import 'package:hues_dovui/src/resource/model/app.dart';
import 'package:hues_dovui/src/resource/repository/other_repository.dart';
import 'package:hues_dovui/src/routers.dart';
import 'package:launch_review/launch_review.dart';
import 'package:provider/provider.dart';

class MoreAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg_moreapp.png'),
              fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset("assets/images/bg_moreapp_head.png"),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Image.asset('assets/images/btn_back.png'),
                    iconSize: 40,
                    onPressed: () => Navigator.pop(context),
                  ),
                )
              ],
            ),
            Expanded(
              child: BaseWidget<MoreAppViewModel>(
                viewModel: MoreAppViewModel(
                  otherRepository: OtherRepository(),
                ),
                onViewModelReady: (viewModel) async {
                  viewModel.setLoading(true);
                  await viewModel.init();
                  viewModel.setLoading(false);
                },
                builder: (context, viewModel, child) {
                  if (viewModel.isLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return WidgetMoreAppList(
                      apps: viewModel.getApps,
                    );
                  }
                },
                child: Text("child"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WidgetMoreAppList extends StatelessWidget {
  final List<App> apps;

  WidgetMoreAppList({
    Key key,
    @required this.apps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 20),
        itemCount: apps.length,
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
        itemBuilder: (context, index) {
          final _app = apps[index];
          return WidgetMoreAppItem(app: _app);
        });
  }
}

class WidgetMoreAppItem extends StatelessWidget {
  final App app;

  const WidgetMoreAppItem({
    Key key,
    @required this.app,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: AssetImage('assets/images/placeholder.jpg'),
        image: NetworkImage(
          app.logolink,
        ),
      ),
      title: Text(app.name ?? "name"),
      trailing: GestureDetector(
        onTap: () => LaunchReview.launch(
            androidAppId: app.linkdown, iOSAppId: app.linkdownios),
        child: Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/btn_download.png'),
                fit: BoxFit.fitWidth),
          ),
          child: Center(child: Text("Download")),
        ),
      ),
    );
  }
}
