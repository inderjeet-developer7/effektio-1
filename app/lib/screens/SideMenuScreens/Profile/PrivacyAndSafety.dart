import 'package:effektio/common/store/themes/SeperatedThemes.dart';
import 'package:effektio/controllers/privacy_session_controller.dart';
import 'package:effektio/screens/SideMenuScreens/Profile/ProtectedAccessScreen.dart';
import 'package:effektio/widgets/AppCommon.dart';
import 'package:effektio/widgets/FlutterSwitch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'SessionManagementScreen.dart';

class PrivacyAndSafety extends StatefulWidget {
  const PrivacyAndSafety({Key? key}) : super(key: key);

  @override
  State<PrivacyAndSafety> createState() => _PrivacyAndSafetyState();
}

class _PrivacyAndSafetyState extends State<PrivacyAndSafety> {
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
          'Privacy and Security',
          style: ProfileTheme.privacyTitleStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  buildSwitchCard(),
                  verticalSpace(16.0),
                  buildSessionCard(),
                  verticalSpace(16.0),
                  buildKeysManagementCard(),
                  verticalSpace(16.0),
                  buildAnalyticsCard(),
                  verticalSpace(16.0),
                  buildOthersCard(),
                  verticalSpace(16.0),
                ],
              ),
            ),
            buildFooter()
          ],
        ),
      ),
    );
  }

  Widget buildSwitchCard() {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'CRYPTOGRAPHY',
              style: ProfileTheme.sectionHeaderStyle,
            ),
          ),
          Card(
            color: ProfileTheme.cardBackgroundColor,
            child: ListTile(
              leading: const Text(
                'Cross-Signing',
                style: ProfileTheme.listTitleStyle,
              ),
              trailing: FlutterSwitch(
                width: 40.0,
                height: 20.0,
                activeColor: ProfileTheme.activeSwitchColor,
                valueFontSize: 12.0,
                toggleSize: 15.0,
                value: controller.crossSigningEnabled.value,
                onToggle: (val) {
                  controller.toggleCrossSigning();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              controller.crossSigningEnabled.value
                  ? 'Cross signing is enabled'
                  : 'Cross signing is not enabled',
              style: ProfileTheme.noteTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSessionCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: ProfileTheme.cardBackgroundColor,
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const SessionManager()));
            },
            leading: const Text(
              'Sessions',
              style: ProfileTheme.listTitleStyle,
            ),
            trailing: SizedBox(
              width: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '4',
                    style: ProfileTheme.primaryTextStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  ProfileTheme.buildArrow(),
                ],
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'All devices currently logged in with your account',
            style: ProfileTheme.noteTextStyle,
          ),
        ),
      ],
    );
  }

  Widget buildKeysManagementCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'CRYPTOGRAPHY KEYS MANAGEMENT',
            style: ProfileTheme.sectionHeaderStyle,
          ),
        ),
        Card(
          color: ProfileTheme.cardBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      showEncryptionKeyBottomSheet(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Encrypted Message Recovery',
                              style: ProfileTheme.listTitleStyle,
                            ),
                            Text(
                              'Manage Key Backup',
                              style: ProfileTheme.listSubtitleStyle,
                            ),
                          ],
                        ),
                        ProfileTheme.buildArrow()
                      ],
                    ),
                  ),
                ),
                buildDivider(
                  2,
                  4.0,
                  0,
                  8,
                  8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Export E2E room keys',
                        style: ProfileTheme.listTitleStyle,
                      ),
                      Text(
                        'Export the keys to local files',
                        style: ProfileTheme.listSubtitleStyle,
                      ),
                    ],
                  ),
                ),
                buildDivider(
                  2,
                  4.0,
                  0,
                  8,
                  8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Import E2E room keys',
                        style: ProfileTheme.listTitleStyle,
                      ),
                      Text(
                        'Import the keys from local files',
                        style: ProfileTheme.listSubtitleStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAnalyticsCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'ANALYTICS',
            style: ProfileTheme.sectionHeaderStyle,
          ),
        ),
        Card(
          color: ProfileTheme.cardBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Send analytics data',
                        style: ProfileTheme.listTitleStyle,
                      ),
                      Text(
                        'Effektio obtains anonymous analytics so that we can enhance the service.',
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
                    value: controller.sendAnalytics.value,
                    onToggle: (val) {
                      if (val) {
                        showAnalyticsBottomSheet(context);
                      } else {
                        controller.toggleSendAnalytics();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildOthersCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'OTHERS',
            style: ProfileTheme.sectionHeaderStyle,
          ),
        ),
        Card(
          color: ProfileTheme.cardBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Prevent screenshot of the application',
                              style: ProfileTheme.listTitleStyle,
                            ),
                            Text(
                              'Enabling this setting adds the FLAQ_SECURE to all activities. Restart the application for the change to take effects.',
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
                          value: controller.makeSecure.value,
                          onToggle: (val) {
                            controller.toggleMakeSecure();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                buildDivider(
                  2,
                  4.0,
                  0,
                  8,
                  8,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ProtectedAccessScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Protect Access',
                          style: ProfileTheme.listTitleStyle,
                        ),
                        Text(
                          'Protect access using PIN or Biometrics',
                          style: ProfileTheme.listSubtitleStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: ProfileTheme.cardBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'Request Data',
              textAlign: TextAlign.center,
              style: ProfileTheme.privacyTitleStyle.copyWith(
                color: AppCommonTheme.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        verticalSpace(8.0),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Check out our Terms of Service and Privacy Policy',
            style: ProfileTheme.sectionHeaderStyle.copyWith(
              color: ProfileTheme.primaryTextColor,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  void showAnalyticsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: ProfileTheme.sheetBackgroundColor,
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setSheetState) {
          return DraggableScrollableSheet(
            initialChildSize: 1,
            minChildSize: 1,
            expand: true,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: const Text(
                            'Help improve Effektio',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'Help us identify issues and improve Effektio by sharing anoynymous usage data. To understand how people use muiltiple devices, we’ll generate a random identifier, shared by your devices',
                        textAlign: TextAlign.center,
                        style: ProfileTheme.sheetTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'You can read all our terms ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'here.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppCommonTheme.primaryColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      buildDivider(
                        2,
                        4.0,
                        0,
                        8,
                        8,
                      ),
                      verticalSpace(22.0),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: AppCommonTheme.primaryColor,
                              ),
                              horizontalSpace(8.0),
                              const Text(
                                'We don’t  record or profile any account data',
                                style: ProfileTheme.sheetTextStyle,
                              )
                            ],
                          ),
                          verticalSpace(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: AppCommonTheme.primaryColor,
                              ),
                              horizontalSpace(8.0),
                              const Text(
                                'We don’t share information with third parties',
                                style: ProfileTheme.sheetTextStyle,
                              )
                            ],
                          ),
                          verticalSpace(8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: AppCommonTheme.primaryColor,
                              ),
                              horizontalSpace(8.0),
                              const Text(
                                'You can turn this off anytime in settings',
                                style: ProfileTheme.sheetTextStyle,
                              )
                            ],
                          ),
                        ],
                      ),
                      verticalSpace(22.0),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            controller.toggleSendAnalytics();
                            Navigator.pop(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppCommonTheme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 84,
                          ),
                          child: Text(
                            'Enable',
                            style: ProfileTheme.primaryTextStyle
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                            'Not now',
                            style: ToDoTheme.listTitleTextStyle.copyWith(
                              color: AppCommonTheme.primaryColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void showEncryptionKeyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: ProfileTheme.sheetBackgroundColor,
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setSheetState) {
          return DraggableScrollableSheet(
            initialChildSize: 0.9,
            minChildSize: 0.5,
            expand: false,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(32.0),
                        child: Image.asset('assets/images/lock_icon.png'),
                      ),
                      Text(
                        'Never lose encrypted messages',
                        textAlign: TextAlign.center,
                        style: ProfileTheme.sheetTextStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                      verticalSpace(16.0),
                      const Text(
                        'Messages in encypted rooms are secured with end-to-end encryption. Only you and the recipient(s) have the keys to read these messages.',
                        textAlign: TextAlign.center,
                        style: ProfileTheme.sheetTextStyle,
                      ),
                      verticalSpace(16.0),
                      const Text(
                        'Securely back up your keys to avoid losing them',
                        textAlign: TextAlign.center,
                        style: ProfileTheme.sheetTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 28.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppCommonTheme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 64,
                            ),
                            child: Text(
                              'Start Using Key Backup',
                              style: ProfileTheme.primaryTextStyle
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
