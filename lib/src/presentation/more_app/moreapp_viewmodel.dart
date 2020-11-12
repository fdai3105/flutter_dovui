import 'package:hues_dovui/src/presentation/base/base_viewmodel.dart';
import 'package:hues_dovui/src/resource/model/app.dart';
import 'package:hues_dovui/src/resource/repository/other_repository.dart';
import 'package:rxdart/rxdart.dart';

class MoreAppViewModel extends BaseViewModel {
  final OtherRepository otherRepository;
  var appsSubject = BehaviorSubject<List<App>>();

  MoreAppViewModel({this.otherRepository});

  Future<void> init() async {
    final app = await otherRepository.getMoreApps();
    appsSubject.add(app);
  }

  List<App> get getApps => appsSubject.value;

  @override
  void dispose() async {
    await appsSubject.drain();
    appsSubject.close();
    super.dispose();
  }
}
