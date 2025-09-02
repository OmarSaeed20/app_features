import 'package:flutter/material.dart';
import 'app.dart';
import 'config/environment.dart';

void main() {
  Environment.init(BuildEnvironment.staging);
  runApp(const MyApp());
}