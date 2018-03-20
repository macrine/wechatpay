var exec = require('cordova/exec');

exports.pay = function (appid,partnerid,prepayid,noncestr,timestamp,packagevalue,sign,ext, success, error) {
    exec(success, error, 'wechatpay', 'pay', [appid,partnerid,prepayid,noncestr,timestamp,packagevalue,sign,ext]);
};
