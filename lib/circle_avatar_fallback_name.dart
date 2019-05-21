library circle_avatar_fallback_name;

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _fontSize = 16.0;
const double _radius = 20.0;

class CircleAvatarFallbackName extends StatelessWidget {
  final dynamic image;
  final String name;
  final double radius;
  final double fontSize;

  CircleAvatarFallbackName({
    Key key,
    this.image,
    this.name,
    this.radius = _radius,
    this.fontSize = _fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: _getChildCircleAvatar(),
      backgroundImage: _getBackgroundImage(),
    );
  }

  _getBackgroundImage() {
    if (image is String && image.contains("http"))
      return NetworkImage(image);
    else if (image is File)
      return FileImage(image);

    return null;
  }

  _getChildCircleAvatar() {
    if (((image == null) || (image is String && image.isEmpty)) && name != null)
      return _getName();
    else if (image == null)
      return CupertinoActivityIndicator();
    else if ((image is String && image.contains("http")) || (image is File))
      return Container();
    else
      _getName();
  }

  Widget _getName() {
    return Text(
      getInitials(name),
      style: TextStyle(
          color: Colors.white,
          fontSize: fontSize * (radius / _radius)
      ),
    );
  }
}

String getInitials(String name) {
  if (name.isEmpty) return " ";

  List<String> nameArray =
  name.trim().replaceAll(RegExp(r"\s+\b|\b\s"), " ").split(" ");
  String initials = ((nameArray[0])[0] != null ? (nameArray[0])[0] : " ") +
      (nameArray.length == 1 ? " " : (nameArray[nameArray.length - 1])[0]);

  return initials;
}