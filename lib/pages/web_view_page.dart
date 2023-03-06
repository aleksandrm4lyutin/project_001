import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewPage extends StatefulWidget {
  final String link;

  const WebViewPage({Key? key,
    required this.link,
  }) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  final WebViewController webViewController = WebViewController();

  @override
  void initState() {
    super.initState();

    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF212121))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            //debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            //debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            //debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            // debugPrint('''
            //   Page resource error:
            //   code: ${error.errorCode}
            //   description: ${error.description}
            //   errorType: ${error.errorType}
            //   isForMainFrame: ${error.isForMainFrame}
            // ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.link));
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var b = await webViewController.canGoBack();
        if(b) {
          webViewController.goBack();
        }
        return false;
      },
      child: SafeArea(
        child: WebViewWidget(controller: webViewController,),
      ),
    );
  }
}
