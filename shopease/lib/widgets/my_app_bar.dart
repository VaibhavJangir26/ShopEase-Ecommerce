import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key,required this.title});
  final String title;
  @override
  State<MyAppBar> createState() => _MyAppBarState();
}


class _MyAppBarState extends State<MyAppBar> {

  // final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);


  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      elevation: 10,
      title: Text(widget.title),
      centerTitle: true,
      leading: IconButton(onPressed: (){
        setState(() {
          Scaffold.of(context).openDrawer();
        });
      }, icon: const Icon(Icons.horizontal_split)),
      actions: [

      ],
    );
  }
}
