import 'package:app_settings/app_settings.dart';
import 'package:provider_start/core/enums/theme_type.dart';
import 'package:provider_start/core/enums/view_state.dart';
import 'package:provider_start/core/services/dialog_service.dart';
import 'package:provider_start/core/services/key_storage_service.dart';
import 'package:provider_start/core/services/theme_service.dart';
import 'package:provider_start/core/ui_models/base_model.dart';
import 'package:provider_start/locator.dart';

class SettingsModel extends BaseModel {
  final _dialogService = locator<DialogService>();
  final _themeService = locator<ThemeService>();
  final _keyStorageService = locator<KeyStorageService>();

  bool get isNightMode => _keyStorageService.nightMode;

  Future<void> init() async {
    setState(ViewState.Busy);

    setState(ViewState.Idle);
  }

  Future<bool> showAlert({
    String title,
    String desc,
    String buttonCofirmText,
  }) async {
    bool success = false;

    final dialogResult = await _dialogService.showDialog(
      title: title,
      description: desc,
      buttonTitle: buttonCofirmText,
    );

    if (dialogResult.confirmed) {
      success = true;
    }

    return success;
  }

  void toggleNightMode(bool value) {
    bool enabled = _keyStorageService.nightMode;

    if (!enabled) {
      _themeService.changeTheme(ThemeType.Dark);
      _keyStorageService.nightMode = true;
    } else {
      _themeService.changeTheme(ThemeType.Primary);
      _keyStorageService.nightMode = false;
    }

    setState(ViewState.Success);
  }

  void openAppSettings() {
    AppSettings.openAppSettings();
  }
}
