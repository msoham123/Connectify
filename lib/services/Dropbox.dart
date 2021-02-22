import 'dart:io';

import 'package:dropbox_client/dropbox_client.dart';
import 'package:path_provider/path_provider.dart';

class DropBox{


  Future initDropbox() async {
    // init dropbox client. (call only once!)
    await Dropbox.init('connectify-app', 'nz4fc655qrmca1o', 'cf93ru4dr9ae413');
  }

  String accessToken = 'ToFJOV-18rgAAAAAAAAAAYVsLYEbP2lriRPTVUoiMC3LZ-mbbZaXkqtOxQ0eMUsU';

  Future testLogin() async {
    // this will run Dropbox app if possible, if not it will run authorization using a web browser.
    await Dropbox.authorize();
  }

  Future getAccessToken() async {
    accessToken = await Dropbox.getAccessToken();
  }

  Future loginWithAccessToken() async {
    await Dropbox.authorizeWithAccessToken(accessToken);
  }

  Future testLogout() async {
    // unlink removes authorization
    await Dropbox.unlink();
  }

  Future testListFolder() async {
    final result = await Dropbox.listFolder(''); // list root folder
    print(result);

    final url = await Dropbox.getTemporaryLink('/file.txt');
    print(url);
  }

  Future testUpload() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    await Dropbox.upload(tempPath, '/file.txt', (uploaded, total) {
      print('progress $uploaded / $total');
    });
  }

  Future testDownload() async {
    final filepath = '/path/to/local/file.txt';
    await Dropbox.download('/dropbox_file.txt', filepath, (downloaded, total) {
      print('progress $downloaded / $total');
    });
  }

  Future uploadTest() async {
      var tempDir = await getTemporaryDirectory();
      var filepath = '${tempDir.path}/test_upload.txt';
      File(filepath).writeAsStringSync(
          'contents.. from ' + (Platform.isIOS ? 'iOS' : 'Android') + '\n');

      final result =
      await Dropbox.upload(filepath, '/test_upload.txt', (uploaded, total) {
        print('progress $uploaded / $total');
      });
      print(result);
  }

  Future uploadPostImage(File file) async {
    // var tempDir = await getTemporaryDirectory();
    // var filepath = '${tempDir.path}/test_upload.txt';
    // File(filepath).writeAsStringSync(
    //     'contents.. from ' + (Platform.isIOS ? 'iOS' : 'Android') + '\n');
    await Dropbox.upload(file.path, '/postImages/${file.path.split("/")[file.path.split("/").length-1]}', (uploaded, total) {
      print('progress $uploaded / $total');
    });
    return '/postImages/${file.path.split("/")[file.path.split("/").length-1]}';
  }

  Future uploadProfileImage(File file) async {
    // var tempDir = await getTemporaryDirectory();
    // var filepath = '${tempDir.path}/test_upload.txt';
    // File(filepath).writeAsStringSync(
    //     'contents.. from ' + (Platform.isIOS ? 'iOS' : 'Android') + '\n');
    await Dropbox.upload(file.path, '/profileImages/${file.path.split("/")[file.path.split("/").length-1]}', (uploaded, total) {
      print('progress $uploaded / $total');
    });
    return '/profileImages/${file.path.split("/")[file.path.split("/").length-1]}';
  }

  Future uploadStartupImage(File file) async {
    // var tempDir = await getTemporaryDirectory();
    // var filepath = '${tempDir.path}/test_upload.txt';
    // File(filepath).writeAsStringSync(
    //     'contents.. from ' + (Platform.isIOS ? 'iOS' : 'Android') + '\n');
    await Dropbox.upload(file.path, '/startupImages/${file.path.split("/")[file.path.split("/").length-1]}', (uploaded, total) {
      print('progress $uploaded / $total');
    });
    return '/startupImages/${file.path.split("/")[file.path.split("/").length-1]}';
  }

  Future downloadTest() async {
      var tempDir = await getTemporaryDirectory();
      var filepath = '${tempDir.path}/test_download.zip'; // for iOS only!!
      print(filepath);
      final result = await Dropbox.download('/file_in_dropbox.zip', filepath,
              (downloaded, total) {
            print('progress $downloaded / $total');
          });

      print(result);
      print(File(filepath).statSync());
    }


  Future<String> getTemporaryLink(path) async {
    final result = await Dropbox.getTemporaryLink(path);
    return result;
  }



  Future listFolder(path) async {
    final result = await Dropbox.listFolder(path);
    return result;
  }



}