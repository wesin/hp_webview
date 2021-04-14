if (window.js == undefined) {
    window.js = {
        handler : _create_handler()
    };
}

/**
 * 创建 JS 处理器
 * 
 * @returns JS 处理器
 */
function _create_handler() {
    var handler = {};

    /**
     * 获取单个条码结果
     * 
     * @param callback
     *            回调方法名 请在页面中定义回调 JS 方法，参数为结果 JSON 字符串数组，空数组表示取消
     */
    handler.barcode = function(callback) {
        var arr = {'callback':callback,'boolmulticodes':false}
        window.flutter_inappwebview.callHandler('barcode', arr);
    }

    /**
     * 获取多个条码结果
     * 
     * @param callback
     *            回调方法名 请在页面中定义回调 JS 方法，参数为结果 JSON 字符串数组，空数组表示取消
     */
    handler.barcodes = function(callback) {
        var content = {'callback':callback, 'boolmulticodes':true}
        window.flutter_inappwebview.callHandler('barcodes', content);
    }

    /**
     * 获取多个条码结果并启用二维码
     * 
     * @param callback
     *            回调方法名 请在页面中定义回调 JS 方法，参数为结果 JSON 字符串数组，空数组表示取消
     */
    handler.barcodes_with_qr = function(callback) {
        var content = {'callback':callback, 'boolmulticodes':false,'boolTwoDimonsion':true}
        window.flutter_inappwebview.callHandler('barcode', content);
    }

    /**
     * 拨打电话
     * 
     * @param phone
     *            电话号码
     */
    handler.call = function(phone) {
        var content = {'phone':phone}
        window.flutter_inappwebview.callHandler('call', content);
    }
    
    handler.openOutUrl = function(url) {
        var content = {'url':url}
        window.flutter_inappwebview.callHandler('openOutUrl', content);
    }

    /**
     * 关闭界面
     */
    handler.close = function() {
        window.flutter_inappwebview.callHandler('close');
    }


    /**
     * 打开新网页界面并指定界面标题
     * 
     * @param url
     *            网页地址
     * @param title
     *            界面标题
     */
    handler.open_url_with_title = function(url, title) {
        var content = {'url':url,'title':title}
        window.flutter_inappwebview.callHandler('openUrl', content);
    }

    /**
     * 打开新网页界面并指定是否全屏
     * 
     * @param url
     *            网页地址
     * @param fullscreen
     *            界面是否全屏
     */
    handler.open_url_with_fullscreen = function(url, fullscreen) {
        var content = {'url':url, 'boolfullscreen':fullscreen}
        window.flutter_inappwebview.callHandler('openUrl', content);
    }

    /**
     * 打开新网页界面并指定界面标题及是否全屏
     * 
     * @param url
     *            网页地址
     * @param title
     *            界面标题
     * @param fullscreen
     *            界面是否全屏
     */
    handler.open_url_with_T_F = function(url, title, fullscreen) {
        var content = {'url':url, 'title':title, 'boolfullscreen':fullscreen}
        window.flutter_inappwebview.callHandler('openUrl', content);
    }

    /**
     * 打开新网页界面并指定界面标题、是否全屏及界面方向
     * 
     * @param url
     *            网页地址
     * @param title
     *            界面标题
     * @param fullscreen
     *            界面是否全屏
     * @param orientation
     *            界面方向
     */
    handler.open_url_with_T_F_O = function(url, title, fullscreen, orientation) {
        var content = {'url':url, 'title':title, 'boolfullscreen':fullscreen, 'orientation':orientation}
        window.flutter_inappwebview.callHandler('openUrl', content);
    }
    
    handler.openUrlWithFilterUrl = function(url, title, filterUrl, filterTitle) {
        var content = {'url':url,'title':title, 'filterurl':filterUrl, 'filtertitle':filterTitle}
        window.flutter_inappwebview.callHandler('openUrl', content);
    }
    
    /**
     * 界面完成
     *
     * @param content
     *            完成内容
     */
    handler.finish = function(content) {
        var jsonStr = JSON.stringify(content);
        window.flutter_inappwebview.callHandler('finish', jsonStr);
    }
    
    handler.logout = function() {
        window.flutter_inappwebview.callHandler('logout');
    }
    
    
    
    /**
     * 获取本地存储数据
     *
     * @param key
     *            数据键值
     */
    handler.getData = function(key, callback) {
        window.flutter_inappwebview.callHandler('getData', {'key':key,'callback':callback});
    }
    
    
    
    /**
     * 设置本地存储数据
     *
     * @param key
     *            数据键值
     * @param data
     *            数据内容
     */
    handler.setData = function(key, data, callback) {
        var content = {'key':key,'data':data, 'callback':callback}
        window.flutter_inappwebview.callHandler('setData', content);
    }
    
    //获取本地应用版本
    handler.getVersion = function(callback) {
        window.flutter_inappwebview.callHandler('getVersion', {'callback':callback});
    }
    
    handler.showMessage = function(title, message, needcancel, callback) {
        window.flutter_inappwebview.callHandler('showMessage', content);
    }
    
    handler.choiceDate = function(year, month, day, callback) {
        var content = {'year':year,'month':month,'day':day,'callback':callback}
        window.flutter_inappwebview.callHandler('choiceDate', content);
    }
    
    handler.session = function(callback) {
        var arr = {'callback': callback}
        window.flutter_inappwebview.callHandler('session', arr);
    }
    
    handler.oper = function(callback) {
        var arr = {'callback': callback}
        window.flutter_inappwebview.callHandler('oper', arr);
    }
    
    //商品销售统计详情跳转至详情
    handler.openPage = function(key, paramID) {
        var content = {'key':key, 'paramID':paramID}
        window.flutter_inappwebview.callHandler('openPage', content);
    }

    //侧滑返回
    handler.back = function() {
        window.flutter_inappwebview.callHandler('back');
    }
    
    handler.scan = function(callback) {
        var arr = {'callback': callback}
        window.flutter_inappwebview.callHandler('scan', arr);
    }
    
    return handler;
}
