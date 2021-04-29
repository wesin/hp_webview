import 'dart:async';
import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'hp_mime_type_resolver.dart';

class HPWebViewProxy {
  bool _started = false;
  HttpServer? _server;
  int _port = 8080;

  HPWebViewProxy({int port = 9111}) {
    this._port = port;
  }

  ///Starts the server on `http://localhost:[port]/`.
  ///
  ///**NOTE for iOS**: For the iOS Platform, you need to add the `NSAllowsLocalNetworking` key with `true` in the `Info.plist` file (See [ATS Configuration Basics](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW35)):
  ///```xml
  ///<key>NSAppTransportSecurity</key>
  ///<dict>
  ///    <key>NSAllowsLocalNetworking</key>
  ///    <true/>
  ///</dict>
  ///```
  ///The `NSAllowsLocalNetworking` key is available since **iOS 10**.
  Future<void> start() async {
    if (this._started) {
      throw Exception('Server already started on http://localhost:$_port');
    }
    this._started = true;

    var completer = Completer();

    runZonedGuarded(() {
      HttpServer.bind('127.0.0.1', _port).then((server) {
        print('Server running on http://localhost:' + _port.toString());

        this._server = server;

        server.listen((HttpRequest request) async {
          Uint8List body = Uint8List(0);

          var path = request.requestedUri.path;

          try {
            body = await loadContent(path) ?? Uint8List(0);
          } catch (e) {
            print(e.toString());
            request.response.close();
            return;
          }

          var contentType = ['text', 'html'];
          if (!request.requestedUri.path.endsWith('/') &&
              request.requestedUri.pathSegments.isNotEmpty) {
            var mimeType = HPMimeTypeResolver.lookup(request.requestedUri.path);
            if (mimeType != null) {
              contentType = mimeType.split('/');
            }
          }

          request.response.headers.contentType =
              ContentType(contentType[0], contentType[1], charset: 'utf-8');
          request.response.add(body);
          request.response.close();
        });

        completer.complete();
      });
    }, (e, stackTrace) => print('Error: $e $stackTrace'));

    return completer.future;
  }

  Future<Uint8List?> loadContent(String path) async {
    path = (path.startsWith('/')) ? path.substring(1) : path;
    path += (path.endsWith('/')) ? 'index.html' : '';
    var dir = await getApplicationDocumentsDirectory();
    var localDir = Directory('${dir.path}/web/erp');
    var locExists = await localDir.exists();
    if (locExists) {
      var versions = await localDir
          .list()
          .where((event) => !event.path.endsWith('.zip'))
          .map((event) => event.path)
          .toList();
      if (versions.length >= 1) {
        versions.sort();
        var finalPath = '${versions.last}/$path';
        return File(finalPath).readAsBytes();
      }
    }
    if (!path.startsWith("assets")) {
      path = "assets/" + path;
    }
    try {
      return (await rootBundle.load(path)).buffer.asUint8List();
    } catch (e) {
      print(e);
      return null;
    }
  }

  ///Closes the server.
  Future<void> close() async {
    if (this._server == null) {
      return;
    }
    await this._server!.close(force: true);
    print('Server running on http://localhost:$_port closed');
    this._started = false;
    this._server = null;
  }

  ///Indicates if the server is running or not.
  bool isRunning() {
    return this._server != null;
  }
}
