import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusetek_movies/constants/constants.dart';

Widget imageHeader(imagen) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
      bottomRight: Radius.circular(0),
      bottomLeft: Radius.circular(0),
    ),
    child: Container(
      color: Colors.black,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.7),
          BlendMode.dstIn,
        ),
        child: CachedNetworkImage(
          imageUrl: imagePath + imagen,
          imageBuilder: (context, imageProvider) => Container(
            height: 320.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            height: 320,
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    ),
  );
}
