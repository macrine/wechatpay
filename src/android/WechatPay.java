package org.apache.cordova.wechatpay;

import com.tencent.mm.opensdk.modelpay.PayReq;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;

/**
 * This class echoes a string called from JavaScript.
 */
public class WechatPay extends CordovaPlugin {

  private IWXAPI wxapi = null;
  private static CallbackContext currentCallbackContext;
  private static String appid;

  @Override
  public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
    if (action.equals("pay")) {
      appid = args.getString(0);
      String partnerid = args.getString(1);
      String prepayid = args.getString(2);
      String noncestr = args.getString(3);
      String timestamp = args.getString(4);
      String packagevalue = args.getString(5);
      String sign = args.getString(6);
      String ext = args.getString(7);
      this.pay(appid, partnerid, prepayid, noncestr, timestamp, packagevalue, sign, ext, callbackContext);
      return true;
    }
    return false;
  }

  private void pay(String appid, String partnerid, String prepayid, String noncestr, String timestamp, String packagevalue, String sign, String ext, CallbackContext callbackContext) {
    IWXAPI wxapi = WXAPIFactory.createWXAPI(this.cordova.getActivity(), appid);
    PayReq req = new PayReq();
    req.appId = appid;
    req.partnerId = partnerid;
    req.prepayId = prepayid;
    req.nonceStr = noncestr;
    req.timeStamp = timestamp;
    req.packageValue = packagevalue;
    req.sign = sign;
    req.extData = "app data"; // optional
    wxapi.sendReq(req);

    currentCallbackContext=callbackContext;

//    if (appid != null && appid.length() > 0) {
//      callbackContext.success(appid);
//    } else {
//      callbackContext.error("Expected one non-empty string argument.");
//    }
  }

  static CallbackContext getCallbackContext(){
    return currentCallbackContext;
  }
  public static String getAppId(){
    return appid;
  }
}
