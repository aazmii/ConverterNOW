import 'dart:developer';
import 'dart:ui' show Offset;

import 'package:flutter/services.dart' show Size;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

class AppWindowListener extends WindowListener {
  ///Gets called when quitting the app, saving window position and size
  @override
  void onWindowClose() async {
    // Save the window's position and size before closing
    super.onWindowClose();
    await saveWindowPosition();
  }

  static Future<void> saveWindowPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final position = await windowManager.getPosition();
    final size = await windowManager.getSize();
    // log('height: ${size.height}, width ${size.height}', name: 'appWindow');
    log('saving window at (${position.dx}, ${position.dy}) with size (${size.width}, ${size.height})',
        name: 'appWindow');

    await prefs.setDouble('window_x', position.dx);
    await prefs.setDouble('window_y', position.dy);
    await prefs.setDouble('window_width', size.width);
    await prefs.setDouble('window_height', size.height);
    windowManager.destroy();
  }

// Restore the window's position and size
  static Future<void> restoreWindowPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final x = prefs.getDouble('window_x');
    final y = prefs.getDouble('window_y');
    final width = prefs.getDouble('window_width');
    final height = prefs.getDouble('window_height');

    if (x != null && y != null && width != null && height != null) {
      log('restoring window at ($x, $y) with size ($width, $height)', name: 'appWindow');
      await windowManager.setPosition(Offset(x, y));
      await windowManager.setSize(Size(width, height));
    }
  }
}
