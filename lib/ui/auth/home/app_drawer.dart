import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(18),
            color: Colors.blue,
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://scontent.fixc10-1.fna.fbcdn.net/v/t1.6435-9/117224742_2748384152043809_2377213799307874512_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=4BJnxJjRmFYAX_7wUoV&_nc_ht=scontent.fixc10-1.fna&oh=00_AT9xhehie7Yc_hnDoytr2sYaiOPZ9TXD3AvYd4GCb8oLNQ&oe=630F2185')),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
