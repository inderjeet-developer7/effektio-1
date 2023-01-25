import 'package:effektio/common/store/themes/SeperatedThemes.dart';
import 'package:effektio/controllers/privacy_session_controller.dart';
import 'package:effektio/models/SessionInfoModel.dart';
import 'package:effektio/widgets/AppCommon.dart';
import 'package:effektio/widgets/FlutterSwitch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SessionInfo extends StatefulWidget {
  final SessionInfoModel sessionInfoModel;

  const SessionInfo({
    Key? key,
    required this.sessionInfoModel,
  }) : super(key: key);

  @override
  State<SessionInfo> createState() => _SessionInfoState();
}

class _SessionInfoState extends State<SessionInfo> {

  final controller = Get.put(PrivacySessionController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showSessionDetailBottomSheet(controller);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                'assets/images/session_device.svg',
                height: 44,
                width: 44,
              ),
              horizontalSpace(16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.sessionInfoModel.name,
                    style: ProfileTheme.listTitleStyle.copyWith(fontSize: 14),
                  ),
                  Row(
                    children: [
                      Text(
                        'Session ID: ',
                        style: ProfileTheme.primaryTextStyle
                            .copyWith(fontSize: 13),
                      ),
                      Text(
                        widget.sessionInfoModel.sessionID,
                        style:
                            ProfileTheme.listTitleStyle.copyWith(fontSize: 14),
                      ),
                      IconButton(
                        onPressed: () {
                          copyText(context, widget.sessionInfoModel.sessionID);
                        },
                        icon: Image.asset(
                          'assets/images/copy_icon.png',
                          height: 22,
                          width: 22,
                        ),
                      ),
                    ],
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Text(
                          widget.sessionInfoModel.address,
                          style: ProfileTheme.listTitleStyle
                              .copyWith(fontSize: 14),
                        ),
                        Container(
                          height: 4,
                          width: 4,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 6.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        Text(
                          widget.sessionInfoModel.isOnline
                              ? 'Online'
                              : widget.sessionInfoModel.lastSeen,
                          style: ProfileTheme.listTitleStyle.copyWith(
                            color: widget.sessionInfoModel.isOnline
                                ? Colors.green
                                : Colors.white,
                            fontSize:
                                widget.sessionInfoModel.isOnline ? 14 : 12,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              horizontalSpace(16.0),
            ],
          ),
          if (!widget.sessionInfoModel.isCurrent)
            GestureDetector(
              onTap: () {
                showTerminationBottomSheet();
              },
              child: const Icon(
                Icons.close,
                color: ProfileTheme.cardInfoColor,
              ),
            ),
        ],
      ),
    );
  }

  void showSessionDetailBottomSheet(PrivacySessionController sessionController) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: ProfileTheme.sheetBackgroundColor,
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setSheetState) {

          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 12,
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/session_device.svg',
                    height: 56,
                    width: 56,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    widget.sessionInfoModel.name,
                    style: ProfileTheme.listTitleStyle.copyWith(fontSize: 22),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    widget.sessionInfoModel.isOnline
                        ? 'Online'
                        : widget.sessionInfoModel.lastSeen,
                    style: ProfileTheme.listTitleStyle.copyWith(
                      color: widget.sessionInfoModel.isOnline
                          ? Colors.green
                          : Colors.white,
                      fontSize: widget.sessionInfoModel.isOnline ? 16 : 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Card(
                    color: ProfileTheme.cardBackgroundColorDark,
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
                                const Text(
                                  'Session ID:',
                                  style: ProfileTheme.listTitleStyle,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      widget.sessionInfoModel.sessionID,
                                      style: ProfileTheme.primaryTextStyle
                                          .copyWith(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        copyText(context, widget.sessionInfoModel.sessionID);
                                      },
                                      icon: Image.asset(
                                        'assets/images/copy_icon.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          buildDivider(
                            2,
                            4,
                            0,
                            8,
                            8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Session Keys:',
                                  style: ProfileTheme.listTitleStyle,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'huirtu985uvm8ud39-875048j_fnfim',
                                      style: ProfileTheme.primaryTextStyle
                                          .copyWith(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        copyText(context, 'huirtu985uvm8ud39-875048j_fnfim');
                                      },
                                      icon: Image.asset(
                                        'assets/images/copy_icon.png',
                                        height: 20,
                                        width: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          buildDivider(
                            2,
                            4,
                            0,
                            8,
                            8,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Location',
                                  style: ProfileTheme.listTitleStyle,
                                ),
                                Text(
                                  widget.sessionInfoModel.address,
                                  style: ProfileTheme.primaryTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    color: ProfileTheme.cardBackgroundColorDark,
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
                                  'Encrypt to verified session only',
                                  style: ProfileTheme.listTitleStyle,
                                ),
                                Text(
                                  'Never send encrypted messages to unverified sessions from this session.',
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
                              value: sessionController.sendEncryptedOnVerified.value,
                              onToggle: (val) {
                                sessionController.toggleSendEncryptedOnVerified();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  if (!widget.sessionInfoModel.isCurrent)
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        showTerminationBottomSheet();
                      },
                      child: Card(
                        color: ProfileTheme.cardBackgroundColorDark,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Terminate Session',
                                style: ProfileTheme.primaryTextStyle.copyWith(
                                  color: AppCommonTheme.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showTerminationBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: ProfileTheme.sheetBackgroundColor,
      context: context,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setSheetState) {
          return SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
              margin: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm Termination Session',
                    style: ProfileTheme.listTitleStyle.copyWith(fontSize: 22),
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  const Text(
                    'Are you sure you want to log out from this device?',
                    style: ProfileTheme.listSubtitleStyle,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style:
                                TextStyle(color: AppCommonTheme.primaryColor),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            side: MaterialStateProperty.all(
                              const BorderSide(
                                color: AppCommonTheme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Confirm',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppCommonTheme.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
