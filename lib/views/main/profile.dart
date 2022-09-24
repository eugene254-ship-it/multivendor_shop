import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multivendor_shop/components/loading.dart';
import 'package:multivendor_shop/constants/colors.dart';

import '../../components/kListTile.dart';
import '../auth/customer_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var firebase = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance;
  var userId = FirebaseAuth.instance.currentUser!.uid;
  var credential;
  var isLoading = true;
  var isInit = true;

  // fetch user credentials
  _fetchUserDetails() async {
    credential = await firebase.collection('users').doc(userId).get();
    setState(() {
      isLoading = false;
    });
  }

  _logout() {
    auth.signOut();
    Navigator.of(context).pushNamed(CustomerAuth.routeName);
  }

  _editProfile() {
    Navigator.of(context).pushNamed('');
  }

  _settings() {
    Navigator.of(context).pushNamed('');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (isInit) {
      _fetchUserDetails();
    }
    setState(() {
      isInit = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isLoading
        ? const Center(
            child: Loading(
              color: primaryColor,
              kSize: 50,
            ),
          )
        : CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                expandedHeight: 130,
                backgroundColor: Colors.white,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    return FlexibleSpaceBar(
                      title: AnimatedOpacity(
                        opacity: constraints.biggest.height <= 120 ? 1 : 0,
                        duration: const Duration(
                          milliseconds: 300,
                        ),
                        child: const Text('Profile'),
                      ),
                      background: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              primaryColor,
                              Colors.black26,
                            ],
                            stops: [0.1, 1],
                            end: Alignment.topRight,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 65,
                              backgroundColor: primaryColor,
                              backgroundImage: NetworkImage(
                                credential['image'],
                              ),
                            ),
                            Text(
                              credential['fullname'],
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: size.width / 0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 10,
                                  ),
                                  primary: bWhite,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Cart',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  primary: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Order',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  primary: bWhite,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Wishlist',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 50,
                            child: Divider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Account Information',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: Divider(
                              thickness: 2,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: size.height / 2.8,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            KListTile(
                              title: 'Email Address',
                              subtitle: credential['email'],
                              icon: Icons.email,
                              onTapHandler: () {},
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(thickness: 1),
                            ),
                            KListTile(
                              title: 'Phone Number',
                              subtitle: credential['phone'] == ""
                                  ? 'Not set yet'
                                  : credential['phone'],
                              icon: Icons.phone,
                              onTapHandler: () {},
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(thickness: 1),
                            ),
                            KListTile(
                              title: 'Delivery Address',
                              subtitle: credential['address'] == ""
                                  ? 'Not set yet'
                                  : credential['address'],
                              icon: Icons.location_pin,
                              onTapHandler: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: size.height / 5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            KListTile(
                              title: 'Edit Profile',
                              subtitle: '',
                              icon: Icons.edit_note,
                              onTapHandler: _editProfile,
                              showSubtitle: false,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(thickness: 1),
                            ),
                            KListTile(
                              title: 'Settings and Config',
                              subtitle: '',
                              icon: Icons.settings,
                              onTapHandler: _settings,
                              showSubtitle: false,

                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Divider(thickness: 1),
                            ),
                            KListTile(
                              title: 'Logout',
                              subtitle: '',
                              icon: Icons.logout,
                              onTapHandler: _logout,
                              showSubtitle: false,

                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
  }
}
