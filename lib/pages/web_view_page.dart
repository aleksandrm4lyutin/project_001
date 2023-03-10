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

  //final WebViewController webViewController = WebViewController();
  WebViewController? _controller;

  late bool isLoading = true;

  @override
  void initState() {
    super.initState();
    //isLoading = true;
    // webViewController
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0xFF212121))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         setState(() {
    //           isLoading = true;
    //         });
    //       },
    //       onPageStarted: (String url) {
    //       },
    //       onPageFinished: (String url) {
    //         setState(() {
    //           isLoading = false;
    //         });
    //       },
    //       onWebResourceError: (WebResourceError error) {
    //       },
    //       onNavigationRequest: (NavigationRequest request) {
    //         debugPrint('allowing navigation to ${request.url}');
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse(widget.link));
  }


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Builder(
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              if(await _controller!.canGoBack()) {
                _controller!.goBack();
              }
              return false;
            },
            child: Stack(
              children: [
                WebView(
                  onProgress: (int progress) {
                    setState(() {
                      isLoading = true;
                    });
                  },
                  onPageFinished: (String url) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                  initialUrl: widget.link,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller = webViewController;
                  },
                  gestureNavigationEnabled: true,
                ),
                isLoading ? const Center(
                  child: CircularProgressIndicator(color: Colors.white,),
                ) : const SizedBox(height: 0,),
              ],
            ),
          );
        },
      ),
    );
    // return WillPopScope(
    //   onWillPop: () async {
    //     var b = await webViewController.canGoBack();
    //     if(b) {
    //       webViewController.goBack();
    //     }
    //     return false;
    //   },
    //   child: SafeArea(
    //     child: Stack(
    //       children: [
    //         WebViewWidget(
    //           controller: webViewController,
    //         ),
    //         isLoading ? const Center(
    //             child: CircularProgressIndicator(
    //               color: Colors.white,
    //             ),
    //         ) : const SizedBox(height: 0,),
    //       ],
    //     )
    //   ),
    // );
  }
}
