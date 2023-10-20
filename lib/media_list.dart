import 'package:flutter/material.dart';
import 'package:movieapp_200561/common/HttpHandler.dart';
import 'package:movieapp_200561/media_detail.dart';
import 'package:movieapp_200561/model/Media.dart';
import 'package:movieapp_200561/media_list_item.dart';
import 'package:movieapp_200561/media_detail.dart';
import 'package:movieapp_200561/common/MediaProvider.dart';

class MediaList extends StatefulWidget {
  final MediaProvider provider;
    String category;
  MediaList(this.provider, this.category);
  @override
  _MediaListState createState() =>
      new _MediaListState();
}

class _MediaListState extends State<MediaList> {
  List<Media> _media = [];
  @override
  void initState() {
    super.initState();
    loadMedia();
  }

  @override
  void didUpdateWidget(MediaList oldWidget) {
    if (oldWidget.provider.runtimeType != widget.provider.runtimeType) {
      _media = [];
      loadMedia();
    }
    super.didUpdateWidget(oldWidget);
  }

  void loadMedia() async {
    var media = await widget.provider.fetchMedia(widget.category);
    setState(() {
      _media.addAll(media);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView.builder(
        itemCount: _media.length,
        itemBuilder: (BuildContext context, int index) {
          return new ElevatedButton(
            child: new MediaListItem(_media[index]),
            onPressed: () {
              Navigator.push(context, new MaterialPageRoute(builder: (context) {
                return new MediaDetail(_media[index]);
              }));
            },
          );
        },
      ),
    );
  }
}
