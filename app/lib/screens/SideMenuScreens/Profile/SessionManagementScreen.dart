import 'package:beamer/beamer.dart';
import 'package:effektio/common/store/MockData.dart';
import 'package:effektio/common/store/themes/SeperatedThemes.dart';
import 'package:effektio/widgets/AppCommon.dart';
import 'package:effektio/widgets/SessionInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SessionManager extends StatefulWidget {
  const SessionManager({Key? key}) : super(key: key);

  @override
  State<SessionManager> createState() => _SessionManagerState();
}

class _SessionManagerState extends State<SessionManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Beamer.of(context).beamBack(),
          icon: SvgPicture.asset(
            'assets/images/back_button.svg',
            color: AppCommonTheme.svgIconColor,
          ),
        ),
        title: const Text(
          'Manage Sessions',
          style: ProfileTheme.privacyTitleStyle,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () => buildInfoDialog(),
              child: const Icon(
                FlutterIcons.exclamation_evi,
                color: Colors.white,
                size: 24,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'CURRENT SESSION',
                style: ProfileTheme.sectionHeaderStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: ProfileTheme.cardBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SessionInfo(
                    sessionInfoModel: sessionModels[0],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'OTHER SESSIONS',
                style: ProfileTheme.sectionHeaderStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: ProfileTheme.cardBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sessionModels.length - 1,
                    itemBuilder: (context, index) {
                      return SessionInfo(
                        sessionInfoModel: sessionModels[index + 1],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(),
                      );
                    },
                  ),
                ),
              ),
            ),
            buildInactiveCard(),
          ],
        ),
      ),
    );
  }

  Widget buildInactiveCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'AUTOMATICALLY TERMINATE OLD SESSIONS',
              style: ProfileTheme.sectionHeaderStyle,
            ),
          ),
          Card(
            color: ProfileTheme.cardBackgroundColor,
            child: ListTile(
              onTap: () {
                showInactiveBottomSheet(context);
              },
              leading: const Text(
                'If Inactive For',
                style: ProfileTheme.listTitleStyle,
              ),
              trailing: SizedBox(
                width: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '1 Week',
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
        ],
      ),
    );
  }

  Future buildInfoDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Dialog(
          backgroundColor: ToDoTheme.backgroundGradientColor,
          child: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Here are all the devices that are currently logged in with your Effektio account. You can log out of each one individually or all other account',
                        textAlign: TextAlign.center,
                        style: ProfileTheme.primaryTextStyle
                            .copyWith(color: Colors.white),
                      ),
                      verticalSpace(20.0),
                      Text(
                        'If you see an entry you do not recognize, you are advised to log out of that device and change your Effektio password immediately',
                        textAlign: TextAlign.center,
                        style: ProfileTheme.primaryTextStyle
                            .copyWith(color: Colors.white),
                      ),
                      verticalSpace(16.0),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 48,
                            vertical: 10,
                          ),
                          decoration: const BoxDecoration(
                            color: AppCommonTheme.primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100.0)),
                          ),
                          child: const Text(
                            'Okay',
                            style: ToDoTheme.subtitleTextStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void showInactiveBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: ProfileTheme.sheetBackgroundColor,
      context: context,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Text(
                        'If Inactive for',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  buildDivider(
                    2,
                    0.0,
                    0.0,
                    8,
                    8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      '1 week',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  buildDivider(
                    2,
                    0.0,
                    0.0,
                    8,
                    8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      '1 month',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  buildDivider(
                    2,
                    0.0,
                    0.0,
                    8,
                    8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      '3 months',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  buildDivider(
                    2,
                    0.0,
                    0.0,
                    8,
                    8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      '6 months',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  buildDivider(
                    2,
                    0.0,
                    0.0,
                    8,
                    8,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      '1 year',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  buildDivider(
                    2,
                    0.0,
                    0.0,
                    8,
                    8,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
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
}
