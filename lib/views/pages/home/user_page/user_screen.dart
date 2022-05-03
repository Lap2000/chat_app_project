import 'package:chat_app_project/database/services/user_service.dart';
import 'package:chat_app_project/views/pages/home/user_page/edit_user_screen.dart';
import 'package:chat_app_project/views/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../widgets/colors.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: UserService.getUserInfo(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 8,
                    ),
                    Center(
                      child: CustomText(
                        fontsize: 40,
                        text: '${snapshot.data.get('fullName')}',
                        fontFamily: 'DancingScript',
                        color: MyColors.yellowColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditUserInfoScreen()),
                        );
                      },
                      iconSize: 25,
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 100,
                  width: 100,
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage('${snapshot.data.get('avartaURL')}'),
                        ),
                      ),
                      Positioned(
                        bottom: -16,
                        right: -15,
                        child: IconButton(
                          onPressed: () {
                            UserService.getUserInfo();
                          },
                          icon: Icon(
                            Icons.upload_sharp,
                            color: Colors.greenAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 20),
                // CustomText(
                //   alignment: Alignment.center,
                //   fontsize: 20,
                //   text: snapshot.data.get('fullName') == null
                //       ? ''
                //       : '${snapshot.data.get('fullName')}',
                //   fontFamily: 'Inter',
                //   color: Colors.black,
                // ),
                const SizedBox(height: 10),
                CustomText(
                  alignment: Alignment.center,
                  fontsize: 25,
                  text: '${snapshot.data.get('email')}',
                  fontFamily: 'DancingScript',
                  color: MyColors.yellowColor,
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.green,
                    labelColor: Colors.red,
                    indicator: MaterialIndicator(
                      height: 3,
                      topLeftRadius: 0,
                      topRightRadius: 0,
                      bottomLeftRadius: 5,
                      bottomRightRadius: 5,
                      horizontalPadding: 16,
                      tabPosition: TabPosition.bottom,
                    ),
                    tabs: const <Widget>[
                      Tab(
                        icon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.video_collection,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: MediaQuery.of(context).size.height - 363,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, top: 22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  CustomText(
                                    alignment: Alignment.centerLeft,
                                    fontsize: 14,
                                    text: 'Full Name ',
                                    fontFamily: 'Poppins',
                                    color: Colors.black26,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    alignment: Alignment.centerLeft,
                                    fontsize: 20,
                                    text: '${snapshot.data.get('fullName')}',
                                    fontFamily: 'Montserrat',
                                    color: Colors.black87,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomText(
                                    alignment: Alignment.centerLeft,
                                    fontsize: 14,
                                    text: 'Phone Number ',
                                    fontFamily: 'Poppins',
                                    color: Colors.black26,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    alignment: Alignment.centerLeft,
                                    fontsize: 20,
                                    text: '${snapshot.data.get('phone')}',
                                    fontFamily: 'Montserrat',
                                    color: Colors.black87,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomText(
                                    alignment: Alignment.centerLeft,
                                    fontsize: 14,
                                    text: 'Age',
                                    fontFamily: 'Poppins',
                                    color: Colors.black26,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    alignment: Alignment.centerLeft,
                                    fontsize: 20,
                                    text: '${snapshot.data.get('age')}',
                                    fontFamily: 'Montserrat',
                                    color: Colors.black87,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomText(
                                    alignment: Alignment.centerLeft,
                                    fontsize: 14,
                                    text: 'Gender',
                                    fontFamily: 'Poppins',
                                    color: Colors.black26,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    alignment: Alignment.centerLeft,
                                    fontsize: 20,
                                    text: '${snapshot.data.get('gender')}',
                                    fontFamily: 'Montserrat',
                                    color: Colors.black87,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomText(
                                    alignment: Alignment.centerLeft,
                                    fontsize: 14,
                                    text: 'Email',
                                    fontFamily: 'Poppins',
                                    color: Colors.black26,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    alignment: Alignment.centerLeft,
                                    fontsize: 20,
                                    text: '${snapshot.data.get('email')}',
                                    fontFamily: 'Montserrat',
                                    color: Colors.black87,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Center(
                        child: Text("It's rainy here"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
