import 'package:flutter/material.dart';
import 'app.dart';
import 'config/environment.dart';

void main() {
  Environment.init(BuildEnvironment.dev);
  runApp(const MyApp());
}