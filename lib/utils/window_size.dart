import 'package:converterpro/utils/window_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class PersistantWindow extends StatefulWidget {
  const PersistantWindow({super.key, required this.child});
  final Widget child;
  @override
  State<PersistantWindow> createState() => _PersistantWindowState();
}

class _PersistantWindowState extends State<PersistantWindow> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  Widget build(BuildContext context)  => widget.child;
  
  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }
  @override
  void onWindowClose() async {
    // Save the window's position and size before closing
    super.onWindowClose();
    await AppWindowListener.saveWindowPosition();
  }
}
