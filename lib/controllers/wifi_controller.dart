import 'package:meal_planner/components/export_files.dart';

class WifiController extends ChangeNotifier {
  bool _isOffline = false;
  bool get isOffline => _isOffline;
  set isOffline(bool isOffline) {
    if (_isOffline == isOffline) return;
    _isOffline = isOffline;
    notifyListeners();
  }
}
