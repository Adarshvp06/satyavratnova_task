import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Duration duration = const Duration(seconds:3);
const double padding = 8;
const double paddingLarge = 16;
const double middlePadding = 24;
const double paddingXL = 32;
const double paddingXXL = 64;
const double paddingSmall = 4;
const double paddingTiny = 2;

const gap = Gap(padding);
const gapLarge = Gap(paddingLarge);
const gapXL = Gap(paddingXL);
const gapXXL = Gap(paddingXXL);
const gapSmall = Gap(paddingSmall);
const gapTiny = Gap(paddingTiny);

const double defaultBorderRadius = 12;
const double largeBorderRadius = paddingLarge;

const Color primaryColor = Color(0xFF1E1B4B); 
const Color secondaryColor = Color(0xFF6B7280); 
const Color textPrimary = Color(0xFF111827); 
const Color textSecondary = Color(0xFF6B7280); 

List profileImages = [
  "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
  "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
  "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8cG9ydHJhaXR8ZW58MHx8MHx8fDA%3D",
];

String get randomProfileImage {
  List newList = List.from(profileImages);
  newList.shuffle();
  return newList.first;
}

List<String> firstNames = [
  "Emma",
  "Olivia",
  "Ava",
  "Isabella",
  "Sophia",
  "Mia",
];

List<String> lastNames = [
  "Smith",
  "Johnson",
  "Williams",
  "Brown",
  "Jones",
  "Garcia",
];

String get randomName {
  List<String> newFirstNames = List.from(firstNames);
  List<String> newLastNames = List.from(lastNames);

  newFirstNames.shuffle();
  newLastNames.shuffle();

  return "${newFirstNames.first} ${newLastNames.first}";
}

const dummyProfile =
    "https://t3.ftcdn.net/jpg/05/16/27/58/240_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg";