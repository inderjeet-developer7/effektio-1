import 'package:effektio/common/store/themes/SeperatedThemes.dart';
import 'package:flutter/material.dart';

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
        leading: const Icon(Icons.arrow_back_ios_new),
        centerTitle: true,
        actions: const [
          Text(
            'edit',
            style: TextStyle(color: AppCommonTheme.primaryColor),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(),
      ),
    );
  }
}
