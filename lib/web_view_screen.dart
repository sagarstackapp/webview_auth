import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  WebViewController? _controller;
  final CookieManager cookieManager = CookieManager();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onClearCookies(context);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: WebView(
            initialUrl: 'https://www.vidyasaar.com/learn/userDetails',
            javascriptMode: JavascriptMode.unrestricted,
            initialCookies: const [
              // // --------------- Test Stackapp --------------- //
              // WebViewCookie(
              //   name: '__saar_token',
              //   value:
              //       'eyJraWQiOiI3ZGU3NTgzMi0wNzBkLTRmMGEtYjI3MS00M2U4YjZiNzFmOGQiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJlMDk1ZjY0Ny05MWVkLTRlMjAtYTNlMi1kMzAwZDNjYjEyNjAiLCJjbGFzc0NvZGUiOiJjbGFzcy0xMCIsImF1ZCI6Im1vYmlsZSwgd2ViLCBhY2Nlc3MiLCJuYW1lIjoiVGVzdCBTdGFja2FwcCIsImlzcyI6Imh0dHBzOi8vd3d3LnZpZHlhc2Fhci5jb20vYXV0aCIsIm1lZGl1bSI6ImVuIiwiZXhwIjoxNjQwMzQzNDI0LCJpYXQiOjE2NDAyNTcwMjQsImJvYXJkIjoiVUJTRSIsImp0aSI6ImE0ZGM5YTIzLTRlMmEtNDk4NC04NzEwLWQwOWMxMDI4YmUwMCJ9.nlxTtQJ6_XdzCIXpGPEqEEhAlx-a5oY6eZLnHoMMf7dtcghMvAt-zkjN76mEWQytp8zwSMV31GIRmmN2PB3cjRiCAxeFjJyv-dDXbad8fW5xyEdGj9XHc_FQgt8vkdn_cIvTb5VUhnQ-dzaXgV-dWVJReo8b3_1Y1GnGjGT7C-FKezBxLchyUJwat_-VfE5cQFwlT6oqXJnHui2zU3LhjDGyb6HS6uxUSwvdtBASbLqZBQG7EkzwmzNzEY6fMezfJeRS-glbIcxn9K6zCLwg-pCqzh3vw3TX77FtO1SznJwIlhIRj60-nD_MmcvvdHXaTUkgsGSOiA8Y3b8bNVMk0g',
              //   domain: 'www.vidyasaar.com',
              // ),
              // WebViewCookie(
              //   name: '__saar_refresh',
              //   value:
              //       'eyJraWQiOiI3ZGU3NTgzMi0wNzBkLTRmMGEtYjI3MS00M2U4YjZiNzFmOGQiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJlMDk1ZjY0Ny05MWVkLTRlMjAtYTNlMi1kMzAwZDNjYjEyNjAiLCJjbGFzc0NvZGUiOiJjbGFzcy0xMCIsImF1ZCI6Im1vYmlsZSwgd2ViLCBhY2Nlc3MiLCJuYW1lIjoiVGVzdCBTdGFja2FwcCIsImlzcyI6Imh0dHBzOi8vd3d3LnZpZHlhc2Fhci5jb20vYXV0aCIsIm1lZGl1bSI6ImVuIiwiZXhwIjoxNjQwMzQzNDI0LCJpYXQiOjE2NDAyNTcwMjQsImJvYXJkIjoiVUJTRSIsImp0aSI6ImE0ZGM5YTIzLTRlMmEtNDk4NC04NzEwLWQwOWMxMDI4YmUwMCJ9.nlxTtQJ6_XdzCIXpGPEqEEhAlx-a5oY6eZLnHoMMf7dtcghMvAt-zkjN76mEWQytp8zwSMV31GIRmmN2PB3cjRiCAxeFjJyv-dDXbad8fW5xyEdGj9XHc_FQgt8vkdn_cIvTb5VUhnQ-dzaXgV-dWVJReo8b3_1Y1GnGjGT7C-FKezBxLchyUJwat_-VfE5cQFwlT6oqXJnHui2zU3LhjDGyb6HS6uxUSwvdtBASbLqZBQG7EkzwmzNzEY6fMezfJeRS-glbIcxn9K6zCLwg-pCqzh3vw3TX77FtO1SznJwIlhIRj60-nD_MmcvvdHXaTUkgsGSOiA8Y3b8bNVMk0g',
              //   domain: 'www.vidyasaar.com',
              // ),
              // --------------- Ashok Stackapp --------------- //
              WebViewCookie(
                name: '__saar_token',
                value:
                    'eyJraWQiOiI3ZGU3NTgzMi0wNzBkLTRmMGEtYjI3MS00M2U4YjZiNzFmOGQiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI0OTQyMWY3Mi0xNWU0LTQ1YjAtYWI0OC02ZDMyYzgyNjA3YzkiLCJjbGFzc0NvZGUiOiJjbGFzcy0xMCIsImF1ZCI6Im1vYmlsZSwgd2ViLCBhY2Nlc3MiLCJuYW1lIjoiQXNob2sgU3RhY2thcHAiLCJpc3MiOiJodHRwczovL3d3dy52aWR5YXNhYXIuY29tL2F1dGgiLCJtZWRpdW0iOiJlbiIsImV4cCI6MTY0MDQwMzkxNywiaWF0IjoxNjQwMzE3NTE3LCJib2FyZCI6IlVCU0UiLCJqdGkiOiJmZTNkOWZhMS05NzExLTRiNDYtODlmYS0wNjNjMjJhMmUxOTUifQ.RVPZ4bdbX1cZg9Humiwl1GVkFlyyhpgc2O5x-BkittpDrGA2NQ57F4FNuNXvUi2yj_wrgqoSZgMA8WLnEaJAOvwm9LveqCyg6N6UlvCKlvl9-jg2hoFszA4J-YPPcSuP-Kl-BVJ37E48sdLgvuGoJjLpgVFCHy3D2QVEWLTJq6aWl4Io_M-evxWmD3NTnPfgqztOq8CmnqmtKTDiheLR5T9qeStWCsHdh2nY55FYCR0QMk-75X0seP0Rq6B9CWjuh3Qh8t6wHPp26eumhDkAdNSXnoc7d4mmRTuPE2GvQfHysrlDPkdgN0EjHUp4koBAFa8M2nmEC8QjhxILVovpbA',
                domain: 'www.vidyasaar.com',
              ),
              WebViewCookie(
                name: '__saar_refresh',
                value:
                    'eyJraWQiOiI3ZGU3NTgzMi0wNzBkLTRmMGEtYjI3MS00M2U4YjZiNzFmOGQiLCJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI0OTQyMWY3Mi0xNWU0LTQ1YjAtYWI0OC02ZDMyYzgyNjA3YzkiLCJjbGFzc0NvZGUiOiJjbGFzcy0xMCIsImF1ZCI6Im1vYmlsZSwgd2ViLCBhY2Nlc3MiLCJuYW1lIjoiQXNob2sgU3RhY2thcHAiLCJpc3MiOiJodHRwczovL3d3dy52aWR5YXNhYXIuY29tL2F1dGgiLCJtZWRpdW0iOiJlbiIsImV4cCI6MTY0MDQwMzkxNywiaWF0IjoxNjQwMzE3NTE3LCJib2FyZCI6IlVCU0UiLCJqdGkiOiJmZTNkOWZhMS05NzExLTRiNDYtODlmYS0wNjNjMjJhMmUxOTUifQ.RVPZ4bdbX1cZg9Humiwl1GVkFlyyhpgc2O5x-BkittpDrGA2NQ57F4FNuNXvUi2yj_wrgqoSZgMA8WLnEaJAOvwm9LveqCyg6N6UlvCKlvl9-jg2hoFszA4J-YPPcSuP-Kl-BVJ37E48sdLgvuGoJjLpgVFCHy3D2QVEWLTJq6aWl4Io_M-evxWmD3NTnPfgqztOq8CmnqmtKTDiheLR5T9qeStWCsHdh2nY55FYCR0QMk-75X0seP0Rq6B9CWjuh3Qh8t6wHPp26eumhDkAdNSXnoc7d4mmRTuPE2GvQfHysrlDPkdgN0EjHUp4koBAFa8M2nmEC8QjhxILVovpbA',
                domain: 'www.vidyasaar.com',
              ),
            ],
            // javascriptChannels: {
            //   JavascriptChannel(
            //       name: 'messageHandler',
            //       onMessageReceived: (JavascriptMessage message) {
            //         print('JavascriptChannel message --> $message');
            //       }),
            // },
            onWebViewCreated: (WebViewController webviewController) {
              _controller = webviewController;
              // _loadHtmlFromAssets();
            },
            navigationDelegate: (NavigationRequest request) async {
              print('request.url --> ${request.url}');
              // _onClearCookies(context);
              return NavigationDecision.navigate;
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onClearCookies(BuildContext context) async {
    final bool hadCookies = await cookieManager.clearCookies();
    String message = 'There were cookies. Now, they are gone!';
    if (!hadCookies) {
      message = 'There are no cookies.';
    }
    print('Message --> $message');
  }
}
