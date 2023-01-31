import 'package:effektio/common/store/themes/SeperatedThemes.dart';
import 'package:effektio/controllers/privacy_session_controller.dart';
import 'package:effektio/widgets/AppCommon.dart';
import 'package:effektio/widgets/FlutterSwitch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProtectedAccessScreen extends StatefulWidget {
  const ProtectedAccessScreen({Key? key}) : super(key: key);

  @override
  State<ProtectedAccessScreen> createState() => _ProtectedAccessScreenState();
}

class _ProtectedAccessScreenState extends State<ProtectedAccessScreen> {
  final controller = Get.put(PrivacySessionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            'assets/images/back_button.svg',
            color: AppCommonTheme.svgIconColor,
          ),
        ),
        title: const Text(
          'Protect Access',
          style: ProfileTheme.privacyTitleStyle,
        ),
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        color: ProfileTheme.cardBackgroundColor,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Enable PIN',
                          style: ProfileTheme.listTitleStyle,
                        ),
                        Text(
                          'If you want to reset your PIN, tap Forgot PIN to logout and reset',
                          style: ProfileTheme.listSubtitleStyle,
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => FlutterSwitch(
                      width: 40.0,
                      height: 20.0,
                      activeColor: ProfileTheme.activeSwitchColor,
                      valueFontSize: 12.0,
                      toggleSize: 15.0,
                      value: controller.enablePin.value,
                      onToggle: (val) {
                        controller.toggleEnablePin();
                      },
                    ),
                  )
                ],
              ),
            ),
            buildDivider(
              2,
              4.0,
              0.0,
              16,
              16,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProtectedAccessScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Change PIN',
                      style: ProfileTheme.listTitleStyle,
                    ),
                    Text(
                      'Change the current PIN',
                      style: ProfileTheme.listSubtitleStyle,
                    ),
                  ],
                ),
              ),
            ),
            buildDivider(
              2,
              4.0,
              0.0,
              16,
              16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Enable Biometrics',
                          style: ProfileTheme.listTitleStyle,
                        ),
                        Text(
                          'PIN code is only way to unlock Effektio',
                          style: ProfileTheme.listSubtitleStyle,
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => FlutterSwitch(
                      width: 40.0,
                      height: 20.0,
                      activeColor: ProfileTheme.activeSwitchColor,
                      valueFontSize: 12.0,
                      toggleSize: 15.0,
                      value: controller.enableBiometrics.value,
                      onToggle: (val) {
                        controller.toggleEnableBiometrics();
                      },
                    ),
                  )
                ],
              ),
            ),
            buildDivider(
              2,
              4.0,
              0.0,
              16,
              16,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Show content in notifications',
                          style: ProfileTheme.listTitleStyle,
                        ),
                        Text(
                          'Show details like message content and news feed notification.',
                          style: ProfileTheme.listSubtitleStyle,
                        ),
                      ],
                    ),
                  ),
                  Obx(
                    () => FlutterSwitch(
                      width: 40.0,
                      height: 20.0,
                      activeColor: ProfileTheme.activeSwitchColor,
                      valueFontSize: 12.0,
                      toggleSize: 15.0,
                      value: controller.showNotifications.value,
                      onToggle: (val) {
                        controller.toggleShowNotifications();
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
