
              case .dataCreated:
                guard let message = reply["message"] as? String else{
                    fatalError("message not found in server reply: [\(reply)]")
                }
              
              
              self.wireframe.presentCodeVerificationViewController(
                    from: self.view as! GBAVerificationCodeDelegate,
                    completion: {
                        guard let nav = self.view.navigationController else{
                            fatalError("NavigationController was not found in RegistrationPresenter")
                        }
                        SettingsWireframe(nav).navigate(to: .AccessSettingsMainView)
                        
                        //Checking if working :(
                        // or :
                        // SettingsWireframe(nav).navigate(to: .AccessSettingsMainView)
                       //  self.present(nav, animated:true, completion: nil)

                        
                        
                },
                    apiCalls:{ code, vc in
                        
                        self.interactor.remote.SubmitRegistrationVerificationCode(code: code, to: registrationForm.mobile    ?? "", successHandler: {
                        (data, statusCode) in
                        vc.serverDidReply(reply: data, statusCode: statusCode)
                            
                        print(data)
                    })
                }, backAction: {
                    self.view.navigationController?.dismiss(animated: true, completion: nil)
                })
                bridge.didRecievedVerificationData(code: "\(message) \(code)")


//case .badRequest:


    func resendVerificationCode(){
        guard let number = self.registrationForm?.mobile else {
            fatalError("Mobile number was not set for LoginPresenter")
        }
        self.interactor.remote.ResendVerificationCode(to: number) { (reply, statusCode) in
            guard let code = reply["message"] as? String else{
                fatalError("Verification code not found in \(reply)")
            }
            self.showAlert(with: "Verification Code", message: code, completion: {
                print(code)
            })
        }
    }
    
    private func verificationAlert(code: String){
        guard let sender = self.view as? RegistrationViewController else { fatalError("something happened") }
        sender.presentVerificationCode(code: code)
    }
    
        func cancelConfirmation(message:String){
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "Yes", style: .destructive) { (_) in
            self.view.navigationController?.dismiss(animated: true, completion: nil)
        }
        
        let no = UIAlertAction(title: "No", style: .cancel) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(no)
        alert.addAction(yes)
        
        self.view.present(alert, animated: true, completion: nil)
        
    }
