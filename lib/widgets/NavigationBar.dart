// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:custom_navigation_bar/custom_navigation_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class NavigationBar extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     return NavigationBarState();
//   }
//
// }
//
// enum ThemeStyle {
//   Dribbble,
//   Light,
//   NoElevation,
//   AntDesign,
//   BorderRadius,
//   FloatingBar,
//   NotificationBadge,
//   WithTitle,
//   FloatingNotif
// }
//
// class NavigationBarState extends State<NavigationBar>{
//
//   int _currentIndex = 0;
//   var _currentStyle = ThemeStyle.AntDesign;
//   List<int> _badgeCounts = List<int>.generate(5, (index) => index);
//   List<bool> _badgeShows = List<bool>.generate(5, (index) => true);
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildCustomIconDesign();
//   }

  // Widget _buildCustomIconDesign() {
  //   return CustomNavigationBar(
  //     selectedColor: Theme.of(context).buttonColor,
  //     strokeColor: Theme.of(context).buttonColor,
  //     unSelectedColor: Colors.grey[600],
  //     backgroundColor: Colors.white,
  //     items: [
  //       CustomNavigationBarItem(
  //         icon: Center(
  //           child: Icon(
  //             AntDesign.home,
  //             size: 25,
  //           ),
  //         ),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Center(
  //           child: Icon(
  //             AntDesign.shoppingcart,
  //             size: 25,
  //           ),
  //         ),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Center(
  //           child: Icon(
  //             AntDesign.cloudo,
  //             size: 25,
  //           ),
  //         ),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Center(
  //           child: Icon(
  //             AntDesign.search1,
  //             size: 25,
  //           ),
  //         ),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Center(
  //           child: Icon(
  //             AntDesign.user,
  //             size: 25,
  //           ),
  //         ),
  //       ),
  //     ],
  //     currentIndex: _currentIndex,
  //     onTap: (index) {
  //       setState(() {
  //         _currentIndex = index;
  //       });
  //     },
  //   );
  // }



  // Widget _buildBottomNavigationBar() {
  //   switch (_currentStyle) {
  //     case ThemeStyle.Dribbble:
  //       return _buildOriginDesign();
  //     case ThemeStyle.Light:
  //       return _buildLightDesign();
  //     case ThemeStyle.AntDesign:
  //       return _buildCustomIconDesign();
  //     case ThemeStyle.BorderRadius:
  //       return _buildBorderRadiusDesign();
  //     case ThemeStyle.FloatingBar:
  //       return _buildFloatingBar();
  //     case ThemeStyle.NoElevation:
  //       return _buildNoElevation();
  //     case ThemeStyle.NotificationBadge:
  //       return _buildNotificationBadge();
  //     case ThemeStyle.WithTitle:
  //       return _buildTitle();
  //     case ThemeStyle.FloatingNotif:
  //       return _buildFloatingNotifBar();
  //     default:
  //       return _buildOriginDesign();
  //   }
  // }
  //
  // Widget _buildTitle() {
  //   return CustomNavigationBar(
  //     iconSize: 30.0,
  //     selectedColor: Color(0xff040307),
  //     strokeColor: Color(0x30040307),
  //     unSelectedColor: Color(0xffacacac),
  //     backgroundColor: Colors.white,
  //     items: [
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //         title: Text("Home"),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.shopping_cart),
  //         title: Text("Cart"),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.lightbulb_outline),
  //         title: Text("Explore"),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.search),
  //         title: Text("Search"),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.account_circle),
  //         title: Text("Me"),
  //       ),
  //     ],
  //     currentIndex: _currentIndex,
  //     onTap: (index) {
  //       setState(() {
  //         _currentIndex = index;
  //       });
  //     },
  //   );
  // }
  //
  // Widget _buildNotificationBadge() {
  //   return CustomNavigationBar(
  //     iconSize: 30.0,
  //     selectedColor: Color(0xff040307),
  //     strokeColor: Color(0x30040307),
  //     unSelectedColor: Color(0xffacacac),
  //     backgroundColor: Colors.white,
  //     items: [
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //         badgeCount: _badgeCounts[0],
  //         showBadge: _badgeShows[0],
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.shopping_bag),
  //         badgeCount: _badgeCounts[1],
  //         showBadge: _badgeShows[1],
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.lightbulb_outline),
  //         badgeCount: _badgeCounts[2],
  //         showBadge: _badgeShows[2],
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.search),
  //         badgeCount: _badgeCounts[3],
  //         showBadge: _badgeShows[3],
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.account_circle),
  //         badgeCount: _badgeCounts[4],
  //         showBadge: _badgeShows[4],
  //       ),
  //     ],
  //     currentIndex: _currentIndex,
  //     onTap: (index) {
  //       setState(() {
  //         _currentIndex = index;
  //         _badgeShows[index] = false;
  //       });
  //     },
  //   );
  // }
  //
  // Widget _buildOriginDesign() {
  //   return CustomNavigationBar(
  //     iconSize: 30.0,
  //     selectedColor: Colors.white,
  //     strokeColor: Colors.white,
  //     unSelectedColor: Color(0xff6c788a),
  //     backgroundColor: Color(0xff040307),
  //     items: [
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //         title: Text("hello",),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.shopping_cart),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.lightbulb_outline),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.search),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.account_circle),
  //       ),
  //     ],
  //     currentIndex: _currentIndex,
  //     onTap: (index) {
  //       setState(() {
  //         _currentIndex = index;
  //       });
  //     },
  //   );
  // }
  //
  // Widget _buildLightDesign() {
  //   return CustomNavigationBar(
  //     iconSize: 30.0,
  //     selectedColor: Color(0xff040307),
  //     strokeColor: Color(0x30040307),
  //     unSelectedColor: Color(0xffacacac),
  //     backgroundColor: Colors.white,
  //     items: [
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.shopping_cart),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.lightbulb_outline),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.search),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.account_circle),
  //       ),
  //     ],
  //     currentIndex: _currentIndex,
  //     onTap: (index) {
  //       setState(() {
  //         _currentIndex = index;
  //       });
  //     },
  //   );
  // }
  //
  // Widget _buildNoElevation() {
  //   return CustomNavigationBar(
  //     elevation: 0.0,
  //     iconSize: 30.0,
  //     selectedColor: Color(0xff625aff),
  //     strokeColor: Color(0xff625aff),
  //     unSelectedColor: Colors.white,
  //     backgroundColor: Color(0xffa9a5f2),
  //     items: [
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.home),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.shopping_cart),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.lightbulb_outline),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.search),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(Icons.account_circle),
  //       ),
  //     ],
  //     currentIndex: _currentIndex,
  //     onTap: (index) {
  //       setState(() {
  //         _currentIndex = index;
  //       });
  //     },
  //   );
  // }
  //
  //
  //
  // Widget _buildBorderRadiusDesign() {
  //   return CustomNavigationBar(
  //     iconSize: 30.0,
  //     selectedColor: Color(0xff0c18fb),
  //     strokeColor: Color(0x300c18fb),
  //     unSelectedColor: Colors.grey[600],
  //     backgroundColor: Colors.white,
  //     borderRadius: Radius.circular(20.0),
  //     items: [
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.home,
  //         ),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.shoppingcart,
  //         ),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.cloudo,
  //         ),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //             AntDesign.search1,
  //         ),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.user,
  //         ),
  //       ),
  //     ],
  //     currentIndex: _currentIndex,
  //     onTap: (index) {
  //       setState(() {
  //         _currentIndex = index;
  //       });
  //     },
  //   );
  // }
  //
  // Widget _buildFloatingBar() {
  //   return CustomNavigationBar(
  //     iconSize: 30.0,
  //     selectedColor: Color(0xff0c18fb),
  //     strokeColor: Color(0x300c18fb),
  //     unSelectedColor: Colors.grey[600],
  //     backgroundColor: Colors.white,
  //     borderRadius: Radius.circular(20.0),
  //     items: [
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.home,
  //         ),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.shoppingcart,
  //         ),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.cloudo,
  //         ),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.search1,
  //         ),
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.user,
  //         ),
  //       ),
  //     ],
  //     currentIndex: _currentIndex,
  //     onTap: (index) {
  //       setState(() {
  //         _currentIndex = index;
  //       });
  //     },
  //     isFloating: true,
  //   );
  // }
  //
  //
  // Widget _buildFloatingNotifBar() {
  //   return CustomNavigationBar(
  //     iconSize: 30.0,
  //     // selectedColor: Color(0xff0c18fb),
  //     // strokeColor: Color(0x300c18fb),
  //     selectedColor: Theme.of(context).buttonColor,
  //     strokeColor: Theme.of(context).buttonColor,
  //     unSelectedColor: Colors.grey[600],
  //     backgroundColor: Colors.white,
  //     borderRadius: Radius.circular(20.0),
  //     items: [
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.home,
  //         ),
  //         badgeCount: _badgeCounts[0],
  //         showBadge: _badgeShows[0],
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.shoppingcart,
  //         ),
  //         badgeCount: _badgeCounts[1],
  //         showBadge: _badgeShows[1],
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.cloudo,
  //         ),
  //         badgeCount: _badgeCounts[2],
  //         showBadge: _badgeShows[2],
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.search1,
  //         ),
  //         badgeCount: _badgeCounts[3],
  //         showBadge: _badgeShows[3],
  //       ),
  //       CustomNavigationBarItem(
  //         icon: Icon(
  //           AntDesign.user,
  //         ),
  //         badgeCount: _badgeCounts[4],
  //         showBadge: _badgeShows[4],
  //       ),
  //     ],
  //     isFloating: true,
  //     currentIndex: _currentIndex,
  //     onTap: (index) {
  //       setState(() {
  //         _currentIndex = index;
  //         _badgeShows[index] = false;
  //       });
  //     },
  //   );
  // }
//
// }