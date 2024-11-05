import 'package:flutter/material.dart';
import 'package:food_delivery/utils/color.dart';
import 'package:food_delivery/pages/order/order_page.dart';
import 'package:food_delivery/pages/auth/sign_up_page.dart';
import 'package:food_delivery/pages/home/main_food_page.dart';
import 'package:food_delivery/pages/account/account_page.dart';
import 'package:food_delivery/pages/cart/cart_history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  // late PersistentTabController _controller;

  List pages = [
    const MainFoodPage(),
    const OrderPage(),
    const CartHistoryPage(),
    const AccountPage()
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = PersistentTabController(initialIndex: 0);
  // }

  List<Widget> _buildScreens() {
    return [
      const MainFoodPage(),
      const SignUpPage(),
      const CartHistoryPage(),
      const AccountPage(),
    ];
  }

  // List<PersistentBottomNavBarItem> _navBarsItems() {
  //   return [
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.home),
  //       title: ("Home"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.archivebox_fill),
  //       title: ("History"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.cart_fill),
  //       title: ("Cart"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //     PersistentBottomNavBarItem(
  //       icon: Icon(CupertinoIcons.person),
  //       title: ("Me"),
  //       activeColorPrimary: CupertinoColors.activeBlue,
  //       inactiveColorPrimary: CupertinoColors.systemGrey,
  //     ),
  //   ];
  // }

  @override
  // Widget build(BuildContext context) {
  //   return PersistentTabView(
  //     context,
  //     controller: _controller,
  //     screens: _buildScreens(),
  //     items: _navBarsItems(),
  //     handleAndroidBackButtonPress: true, // Default is true.
  //     resizeToAvoidBottomInset:
  //         true, // This needs to be true if you want to move up the screen on a non-scrollable screen when keyboard appears. Default is true.
  //     stateManagement: true, // Default is true.
  //     hideNavigationBarWhenKeyboardAppears: true,
  //     // popBehaviorOnSelectedNavBarItemPress: PopActionScreensType.all,
  //     padding: const EdgeInsets.only(top: 8),
  //     backgroundColor: Colors.grey.shade900,
  //     isVisible: true,
  //     animationSettings: const NavBarAnimationSettings(
  //       navBarItemAnimation: ItemAnimationSettings(
  //         // Navigation Bar's items animation properties.
  //         duration: Duration(milliseconds: 400),
  //         curve: Curves.ease,
  //       ),
  //       screenTransitionAnimation: ScreenTransitionAnimationSettings(
  //         // Screen transition animation on change of selected tab.
  //         animateTabTransition: true,
  //         duration: Duration(milliseconds: 200),
  //         screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
  //       ),
  //     ),
  //     confineToSafeArea: true,
  //     navBarHeight: kBottomNavigationBarHeight,
  //     navBarStyle:
  //         NavBarStyle.style1, // Choose the nav bar style with this property
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTapNav,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Me",
          ),
        ],
      ),
    );
  }
}
