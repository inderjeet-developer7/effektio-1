import 'package:cached_network_image/cached_network_image.dart';
import 'package:effektio/common/store/themes/SeperatedThemes.dart';
import 'package:effektio/screens/SideMenuScreens/Profile/PrivacyAndSafety.dart';
import 'package:effektio/widgets/AppCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                showNotYetImplementedMsg(
                  context,
                  'Edit profile is not implemented yet',
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  'Edit',
                  style: CrossSigningSheetTheme.primaryTextStyle
                      .copyWith(color: AppCommonTheme.primaryColor),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              buildProfileHeader(Colors.white),
              const SizedBox(
                height: 16.0,
              ),
              buildStatusCard(),
              buildFirstSection(),
              buildSecondSection(),
              buildThirdSection(),
              buildFourthSection(),
              buildInviteCard(),
              buildFifthSection(),
              verticalSpace(8.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileHeader(Color borderColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl:
              'https://dragonball.guru/wp-content/uploads/2021/01/goku-dragon-ball-guru.jpg',
          height: 84,
          width: 84,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          maxHeightDiskCache: 120,
          maxWidthDiskCache: 120,
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'John Doe',
                style: ProfileTheme.headerTextStyle,
              ),
              Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
              ),
              Text(
                'John@gmail.com',
                style: CrossSigningSheetTheme.primaryTextStyle
                    .copyWith(fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildStatusCard() {
    return Card(
      color: ProfileTheme.cardBackgroundColor,
      child: ListTile(
        leading: SvgPicture.asset(
          'assets/images/status_filled.svg',
          width: 24,
          height: 24,
        ),
        title: const Text(
          'Status',
          style: ProfileTheme.primaryTextStyle,
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.green,
                ),
              ),
              Text(
                'Online',
                style: ProfileTheme.primaryTextStyle.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFirstSection() {
    return Card(
      color: ProfileTheme.cardBackgroundColor,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/notification_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'Notifications',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          ),
          buildDivider(
            2,
            4.0,
            0.0,
            64,
            16,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/status_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'Saved Items',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          )
        ],
      ),
    );
  }

  Widget buildSecondSection() {
    return Card(
      color: ProfileTheme.cardBackgroundColor,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/account_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'General Account',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          ),
          buildDivider(
            2,
            4.0,
            0.0,
            64,
            16,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/preference_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'Preference',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          ),
          buildDivider(
            2,
            4.0,
            0.0,
            64,
            16,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PrivacyAndSafety()));
            },
            leading: SvgPicture.asset(
              'assets/images/lock_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'Privacy and Safety',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          ),
          buildDivider(
            2,
            4.0,
            0.0,
            64,
            16,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/scan_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'Scan QR Code',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          )
        ],
      ),
    );
  }

  Widget buildThirdSection() {
    return Card(
      color: ProfileTheme.cardBackgroundColor,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/sun_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'Appearance',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          ),
          buildDivider(
            2,
            4.0,
            0.0,
            64,
            16,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/language_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'Language',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          ),
          buildDivider(
            2,
            4.0,
            0.0,
            64,
            16,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/storage_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'Data and Storage usage',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          ),
        ],
      ),
    );
  }

  Widget buildFourthSection() {
    return Card(
      color: ProfileTheme.cardBackgroundColor,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/whats_new_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'Whats New',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          ),
          buildDivider(
            2,
            4.0,
            0.0,
            64,
            16,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/faq_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'Effektio FAQ',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          ),
          buildDivider(
            2,
            4.0,
            0.0,
            64,
            16,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/question_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'Ask a question',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          ),
        ],
      ),
    );
  }

  Widget buildInviteCard() {
    return Card(
      color: ProfileTheme.cardBackgroundColor,
      child: ListTile(
        leading: SvgPicture.asset(
          'assets/images/invite_filled.svg',
          width: 24,
          height: 24,
        ),
        title: const Text(
          'Invite Your Friends',
          style: ProfileTheme.primaryTextStyle,
        ),
      ),
    );
  }

  Widget buildFifthSection() {
    return Card(
      color: ProfileTheme.cardBackgroundColor,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/info_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'About Effektio',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          ),
          buildDivider(
            2,
            4.0,
            0.0,
            64,
            16,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/images/star_filled.svg',
              width: 24,
              height: 24,
            ),
            title: const Text(
              'Rate Us',
              style: ProfileTheme.primaryTextStyle,
            ),
            trailing: ProfileTheme.buildArrow(),
          )
        ],
      ),
    );
  }
}
