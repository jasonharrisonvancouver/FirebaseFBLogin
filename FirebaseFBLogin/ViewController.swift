//
//  ViewController.swift
//  FirebaseFBLogin
//
//  Created by John Muiruri on 14/04/2017.
//  Copyright © 2017 Uko Technologies Limited. All rights reserved.
//

import UIKit
import FacebookLogin
import Firebase
import FBSDKCoreKit

class ViewController: UIViewController, LoginButtonDelegate {
    
    /**
     Called when the button was used to logout.
     
     - parameter loginButton: Button that was used to logout.
     */
    public func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
    
    /**
     Called when the button was used to login and the process finished.
     
     - parameter loginButton: Button that was used to login.
     - parameter result:      The result of the login.
     */
    public func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error):
            print("Error \(error)")
            break
        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
            loginFireBase()
            break
        default: break
        
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lb = LoginButton(readPermissions: [ .email, .publicProfile ])
        lb.center = view.center
        lb.delegate = self
        view.addSubview(lb)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
        Login to Firebase after FB Login is successful
    */
    func loginFireBase() {
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            // ...
            if let error = error {
                // ...
                return
            }
        }
    }
}

