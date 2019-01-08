//
//  ViewController.swift
//  SpeakApp
//

import UIKit

class ViewController: UIViewController {
    var testYodaSpeak:YodaSpeak?
    //CAUTION: please insert your own key for yoda speak app API from Mashaple
    let mashapleYodaApiKey:String = ""
    
    @IBOutlet var inputTextView:UITextView?
    @IBOutlet var yodaLikeTextView:UITextView?
    @IBOutlet var activityIndicator:UIActivityIndicatorView?

    @IBAction func speakLikeYoda(sender:UIButton) {
        if inputTextView != nil && inputTextView?.text != "" {
            self.yodaLikeTextView?.text = ""
            activityIndicator?.startAnimating()
            testYodaSpeak = YodaSpeak.init(string: (inputTextView?.text)!, mashapleKey: mashapleYodaApiKey)
            testYodaSpeak?.yoda(completionHandler: { (yodaSpoke:String?) in
                DispatchQueue.main.async {
                    self.activityIndicator?.stopAnimating()

                    if let answer = yodaSpoke {
                            self.yodaLikeTextView?.text = answer
                    } else {
                        let alert:UIAlertController = UIAlertController.init(title: "Error", message: "Yoda was unable to speak this time.", preferredStyle: UIAlertControllerStyle.alert)
                        let action:UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                        alert.addAction(action)
                        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
                    }
                }
            }
            )
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

