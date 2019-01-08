//
//  YodaSpeak.swift
//  SpeakApp
//

import Foundation

class YodaSpeak {
    let _yodaUrlString:String  = "https://yoda.p.mashape.com/yoda?sentence="
    var _dataTask:URLSessionDataTask?
    var _mashapleKey:String?
    var _inputString:String?
    var _yodaString:String?
    var _url:URL?

    /**
     Initialize YodaSpeak.
     
     @param string String to speak like Yoda.
     @param mashapleKey Mashaple API key
     
     */
    init(string:String, mashapleKey:String) {
        _inputString = string.replacingOccurrences(of: "" , with: "+")
        let str = NSString.init(string:_yodaUrlString + _inputString!).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        _url = URL.init(string: str!)
        _mashapleKey = mashapleKey
    }

    /**
     Speak like Yoda with completion handler.
     
     @param completionHandler Callback after execution of mashaple api request.
     
     */
    func yoda(completionHandler: ((String?) -> Void)!) {
        let request = NSMutableURLRequest.init(url: _url!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 15.0)
        request.addValue(_mashapleKey!, forHTTPHeaderField: "X-Mashape-Key")
        request.addValue("text/plain", forHTTPHeaderField: "Accept")

        if _dataTask != nil {
            _dataTask?.cancel()
        }

        _dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            if error != nil {
                print("error:" + (error?.localizedDescription)!)
                completionHandler(nil)
            } else {
                if (response as! HTTPURLResponse).statusCode == 200 {
                    self._yodaString = String.init(data: data!, encoding: String.Encoding.utf8)!
                    print("yodaSpoke:" + self._yodaString!)
                    completionHandler(self._yodaString)
                } else {
                    completionHandler(nil)
                }
            }
        })

        _dataTask!.resume()
    }
}
