//
//  UIWebView+BlocksKit.m
//  BlocksKit
//

#import "WKWebView+BlocksKit.h"
#import "A2DynamicDelegate.h"
#import "NSObject+A2DynamicDelegate.h"
#import "NSObject+A2BlockDelegate.h"

#pragma mark Custom delegate

@interface A2DynamicWKWebViewDelegate : A2DynamicDelegate <WKNavigationDelegate>
@end

@implementation A2DynamicWKWebViewDelegate


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    BOOL ret = YES;
    id realDelegate = self.realDelegate;
    if (realDelegate && [realDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
        [realDelegate webView:webView decidePolicyForNavigationAction:navigationAction decisionHandler:decisionHandler];

    void (^block)(WKWebView *, WKNavigationAction *, (void (^decisionHandler)(WKNavigationActionPolicy))) = [self blockImplementationForMethod:_cmd];
    if (block)
        block(webView, navigationAction, decisionHandler);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	BOOL ret = YES;
	
	id realDelegate = self.realDelegate;
	if (realDelegate && [realDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
		ret = [realDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];

	BOOL (^block)(UIWebView *, NSURLRequest *, UIWebViewNavigationType) = [self blockImplementationForMethod:_cmd];
	if (block)
		ret &= block(webView, request, navigationType);

	return ret;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    id realDelegate = self.realDelegate;
    if (realDelegate && [realDelegate respondsToSelector:@selector(webView:didStartProvisionalNavigation:)])
        [realDelegate webView:webView didStartProvisionalNavigation:navigation];

    void (^block)(WKWebView *, WKNavigation *) = [self blockImplementationForMethod:_cmd];
    if (block) block(webView, navigation);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    id realDelegate = self.realDelegate;
    if (realDelegate && [realDelegate respondsToSelector:@selector(webView:didFinishNavigation:)])
        [realDelegate webView:webView didFinishNavigation:navigation];

    void (^block)(WKWebView *, WKNavigation *) = [self blockImplementationForMethod:_cmd];
    if (block) block(webView, navigation);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    id realDelegate = self.realDelegate;
    if (realDelegate && [realDelegate respondsToSelector:@selector(webView:didFailNavigation:withError:)])
        [realDelegate webView:webView didFailNavigation:navigation withError:error];
    void (^block)(WKWebView *, NSError *) = [self blockImplementationForMethod:_cmd];
    if (block) block(webView, error);
}

@end

#pragma mark Category

@implementation WKWebView (BlocksKit)

@dynamic bk_shouldStartLoadBlock, bk_didStartLoadBlock, bk_didFinishLoadBlock, bk_didFinishWithErrorBlock;

+ (void)load
{
	@autoreleasepool {
		[self bk_registerDynamicDelegate];
		[self bk_linkDelegateMethods:@{
			@"bk_shouldStartLoadBlock": @"webView:decidePolicyForNavigationAction:decisionHandler:",
			@"bk_didStartLoadBlock": @"webView:didStartProvisionalNavigation:",
			@"bk_didFinishLoadBlock": @"webView:didFinishNavigation:",
			@"bk_didFinishWithErrorBlock": @"webView:didFailNavigation:withError:"
		}];
	}
}

@end
