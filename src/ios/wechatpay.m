/********* wechatpay.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface wechatpay : CDVPlugin {
  // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
@end

@implementation wechatpay

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    [WXApi registerApp：@"wxd930ea5d5a258f4f" withDescription：@"demo 2.0"];

    PayReq *request = [[[PayReq alloc] init] autorelease];
    request.partnerId = @"10000100";
    request.prepayId= @"1101000000140415649af9fc314aa427";
    request.package = @"Sign=WXPay";
    request.nonceStr= @"a462b76e7436e98e0ed6e13c64b4fd1c";
    request.timeStamp= @"1397527777";
    request.sign= @"582282D72DD2B03AD892830965F428CB16E7A256";
    [WXApi sendReq：request];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

  -(void)onResp：(BaseResp*)resp{
			  if ([respisKindOfClass：[PayRespclass]]){
			      PayResp*response=(PayResp*)resp;
			      switch(response.errCode){
			          caseWXSuccess：
                      			//服务器端查询支付通知或查询API返回的结果再提示成功
                      			NSlog(@"支付成功");
                      	break;
                      	default：
                      	NSlog(@"支付失败，retcode=%d",resp.errCode);
                      	break;
                  }
                  	}
                }

@end
