//
//  WKWebView+BlocksKit.h
//  BlocksKit
//

#import "BKDefines.h"
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

/** Block callbacks for WKWebView.

 @warning WKWebView is only available on a platform with UIKit.
*/

@interface WKWebView (BlocksKit)

/** The block to be decide whether a URL will be loaded. 
 
 @warning If the delegate implements webView:shouldStartLoadWithRequest:navigationType:,
 the return values of both the delegate method and the block will be considered.
*/

@property (nonatomic, copy, setter = bk_setShouldStartLoadBlock:, nullable) void (^bk_shouldStartLoadBlock)(WKWebView *webView, WKNavigationAction *navigationAction, (void (^)(WKNavigationActionPolicy)));

//void (^(^complexBlock)(void (^)(WKNavigationActionPolicy)))(void))

//@property (nonatomic, copy, setter = bk_setShouldStartLoadBlock:, nullable) void (^bk_shouldStartLoadBlock)(WKWebView *webView, WKNavigationAction *navigationAction, (void (^)(WKNavigationActionPolicy)) decisionHandler);


//(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))

/** The block that is fired when the web view starts loading. */
@property (nonatomic, copy, setter = bk_setDidStartLoadBlock:, nullable) void (^bk_didStartLoadBlock)(WKWebView *webView, WKNavigation *navigation);

/** The block that is fired when the web view finishes loading. */
@property (nonatomic, copy, setter = bk_setDidFinishLoadBlock:, nullable) void (^bk_didFinishLoadBlock)(WKWebView *webView, WKNavigation *navigation);

/** The block that is fired when the web view stops loading due to an error. */
@property (nonatomic, copy, setter = bk_setDidFinishWithErrorBlock:, nullable) void (^bk_didFinishWithErrorBlock)(WKWebView *webView, NSError *error);

@end

NS_ASSUME_NONNULL_END
