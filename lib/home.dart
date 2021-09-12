import 'package:firebase_storage/firebase_storage.dart';
import 'package:upload_download/api/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:upload_download/widget/download_progress.dart';
import 'package:path_provider/path_provider.dart';

class ImagePage extends StatefulWidget {
  final FirebaseFile file;

  const ImagePage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  DownloadTask? task;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }


  @override
  Widget build(BuildContext context) {
    final isImage = ['.jpeg', '.jpg', '.png'].any(widget.file.name.contains);

    return Scaffold(
      appBar: AppBar(
        title: task != null ? buildDownloadStatus(task!) : Text(widget.file.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () async {
              await FirebaseApi.downloadFile(widget.file.ref);
              print(widget.file.ref.fullPath);
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Progress()));


              final snackBar = SnackBar(
                content: Text('Downloaded ${widget.file.name}'),
              );
              task != null ? buildDownloadStatus(task!) : Container();
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: isImage
          ? Image.network(
        widget.file.url,
        height: double.infinity,
        fit: BoxFit.cover,
      )
          : Center(
        child: Text(
          'Cannot be displayed',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
  //task != null ? buildDownloadStatus(task!) : Container(),

  Widget buildDownloadStatus(DownloadTask task) => StreamBuilder<TaskSnapshot>(
    stream: task.snapshotEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final snap = snapshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);

        return Text(
          '$percentage %',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );
}