/********* wechatpay.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "WXApi.h"
#import "WXApiObject.h"

@interface CDVWechatPay : CDVPlugin {
  // Member variables go here.
    CDVInvokedUrlCommand *cdvcommand;
}

@property (nonatomic, strong) NSString *wechatAppId;

- (void)pay:(CDVInvokedUrlCommand*)command;
@end

@implementation CDVWechatPay


- (void)pluginInitialize {
    NSString* appId = [[self.commandDelegate settings] objectForKey:@"wechatappid"];
    if (appId){
        self.wechatAppId = appId;
        [WXApi registerApp: appId];
    }
}

- (void)pay:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* appid = [command.arguments objectAtIndex:0];
    NSString* partnerid = [command.arguments objectAtIndex:1];
    NSString* prepayid = [command.arguments objectAtIndex:2];
    NSString* noncestr = [command.arguments objectAtIndex:3];
    NSString* timestamp = [command.arguments objectAtIndex:4];
    NSString* packagevalue = [command.arguments objectAtIndex:5];
    NSString* sign = [command.arguments objectAtIndex:6];
    NSString* ext = [command.arguments objectAtIndex:7];

    cdvcommand=command;

//    [WXApi registerApp:@"wxd930ea5d5a258f4f"];

    PayReq *request = [[PayReq alloc] init];
    request.partnerId = partnerid;
    request.prepayId= prepayid;
    request.package = packagevalue;
    request.nonceStr= noncestr;
    request.timeStamp= timestamp;
    request.sign= sign;
    [WXApi sendReq:request];

//    if (echo != nil && [echo length] > 0) {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
//    } else {
//        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//    }
//
//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
			      PayResp*response=(PayResp*)resp;
			      switch(response.errCode){
                      caseWXSuccess:
                      			//服务器端查询支付通知或查询API返回的结果再提示成功
                      			NSLog(@"支付成功");

                          [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"支付成功"] callbackId:cdvcommand.callbackId];
                      	break;
                      default:
                       [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"支付失败"] callbackId:cdvcommand.callbackId];
                      	NSLog(@"支付失败，retcode=%d",resp.errCode);
                      	break;
                  }
                  	}
                }

@end
