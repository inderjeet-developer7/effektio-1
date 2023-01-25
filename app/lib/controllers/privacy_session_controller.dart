import 'package:get/get.dart';

class PrivacySessionController extends GetxController {
  static PrivacySessionController to = Get.find();

  var crossSigningEnabled = false.obs;
  var sendAnalytics = false.obs;
  var makeSecure = false.obs;
  var enablePin = false.obs;
  var enableBiometrics = false.obs;
  var showNotifications = false.obs;
  var sendEncryptedOnVerified = true.obs;

  void toggleCrossSigning() {
    crossSigningEnabled.value = !crossSigningEnabled.value;
    update();
  }

  void toggleSendAnalytics() {
    sendAnalytics.value = !sendAnalytics.value;
    update();
  }

  void toggleMakeSecure() {
    makeSecure.value = !makeSecure.value;
    update();
  }

  void toggleEnablePin() {
    enablePin.value = !enablePin.value;
    update();
  }

  void toggleEnableBiometrics() {
    enableBiometrics.value = !enableBiometrics.value;
    update();
  }

  void toggleShowNotifications() {
    showNotifications.value = !showNotifications.value;
    update();
  }

  void toggleSendEncryptedOnVerified() {
    sendEncryptedOnVerified.value = !sendEncryptedOnVerified.value;
    update();
  }
}
